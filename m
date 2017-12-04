From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4 06/15] soundwire: Add IO transfer
Date: Sun, 3 Dec 2017 21:01:41 -0600
Message-ID: <d7ed6ffa-e9b3-a7c9-ae07-369d2d541eab@linux.intel.com>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-7-git-send-email-vinod.koul@intel.com>
 <40d00228-2891-6e25-4c6f-789518a0e2c2@linux.intel.com>
 <20171203170418.GN32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171203170418.GN32417@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 12/3/17 11:04 AM, Vinod Koul wrote:
> On Fri, Dec 01, 2017 at 05:27:31PM -0600, Pierre-Louis Bossart wrote:
> 
>>> +static inline int find_response_code(enum sdw_command_response resp)
>>> +{
>>> +	switch (resp) {
>>> +	case SDW_CMD_OK:
>>> +		return 0;
>>> +
>>> +	case SDW_CMD_IGNORED:
>>> +		return -ENODATA;
>>> +
>>> +	case SDW_CMD_TIMEOUT:
>>> +		return -ETIMEDOUT;
>>> +
>>> +	default:
>>> +		return -EIO;
>>
>> the 'default' case will handle both SDW_CMD_FAIL (which is a bus event
>> usually due to bus clash or parity issues) and SDW_CMD_FAIL_OTHER (which is
>> an imp-def IP event).
>>
>> Do they really belong in the same basket? From a debug perspective there is
>> quite a bit of information lost.
> 
> at higher level the error handling is same. the information is not lost as
> it is expected that you would log it at error source.

I don't understand this. It's certainly not the same for me if you 
detect an electric problem or if the IP is in the weeds. Logging at the 
source is fine but this filtering prevents higher levels from doing 
anything different.

> 
>>> +static inline int do_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
>>> +{
>>> +	int retry = bus->prop.err_threshold;
>>> +	enum sdw_command_response resp;
>>> +	int ret = 0, i;
>>> +
>>> +	for (i = 0; i <= retry; i++) {
>>> +		resp = bus->ops->xfer_msg(bus, msg);
>>> +		ret = find_response_code(resp);
>>> +
>>> +		/* if cmd is ok or ignored return */
>>> +		if (ret == 0 || ret == -ENODATA)
>>
>> Can you document why you don't retry on a CMD_IGNORED? I know there was a
>> reason, I just can't remember it.
> 
> CMD_IGNORED can be okay on broadcast. User of this API can retry all they
> want!

So you retry if this is a CMD_FAILED but let higher levels retry for 
CMD_IGNORED, sorry I don't see the logic.


> 
>>
>> Now that I think of it, the retry on TIMEOUT makes no sense to me. The retry
>> was intended for bus-level issues, where maybe a single bit error causes an
>> issue without consequences, but the TIMEOUT is a completely different beast,
>> it's the master IP that doesn't answer really, a completely different case.
> 
> well in those cases where you have blue wires, it actually helps :)

Blue wires are not supposed to change electrical behavior. TIMEOUT is 
only an internal SOC level issue, so no I don't get how this helps.

You have a retry count that is provided in the BIOS/firmware through 
disco properties and it's meant to bus errors. You are abusing the 
definitions. A command failed is supposed to be detected at the frame 
rate, which is typically 20us. a timeout is likely a 100s of ms value, 
so if you retry on top it's going to lock up the bus.

> 
>>> +/**
>>> + * sdw_transfer() - Synchronous transfer message to a SDW Slave device
>>> + * @bus: SDW bus
>>> + * @slave: SDW Slave
>>
>> is this just me or this argument is not used?
> 
> That's what happens where API gets reworked umpteen times, thanks for
> pointing. Earlier slave was required to get the page address calculation,
> now that it is removed, it is no longer required !
> 
>>> +int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>>> +		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
>>> +{
>>> +	memset(msg, 0, sizeof(*msg));
>>> +	msg->addr = addr;
>>
>> add comment on implicit truncation to 16-bit address
> 
> Sure..
> 
>>> +	msg->len = count;
>>> +	msg->dev_num = dev_num;
>>> +	msg->flags = flags;
>>> +	msg->buf = buf;
>>> +	msg->ssp_sync = false;
>>> +	msg->page = false;
>>> +
>>> +	if (addr < SDW_REG_NO_PAGE) { /* no paging area */
>>> +		return 0;
>>> +	} else if (addr >= SDW_REG_MAX) { /* illegal addr */
>>> +		pr_err("SDW: Invalid address %x passed\n", addr);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (addr < SDW_REG_OPTIONAL_PAGE) { /* 32k but no page */
>>> +		if (slave && !slave->prop.paging_support)
>>> +			return 0;
>>> +		/* no need for else as that will fall thru to paging */
>>> +	}
>>> +
>>> +	/* paging madatory */
>>
>> mandatory
> 
> thanks for spotting
> 
>>
>>> +	if (dev_num == SDW_ENUM_DEV_NUM || dev_num == SDW_BROADCAST_DEV_NUM) {
>>> +		pr_err("SDW: Invalid device for paging :%d\n", dev_num);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (!slave) {
>>> +		pr_err("SDW: No slave for paging addr\n");
>>> +		return -EINVAL;
>>
>> I would move this test up, since if you have a NULL slave you should return
>> an error in all case, otherwise there will be an oops in the code below ...
> 
> naah, this fn is called for all IO, like broadcast where we have no slave.
> So it is really optional for API, but for paging it is mandatory!
> 
>>
>>> +	} else if (!slave->prop.paging_support) {
> 
> this wont oops as slave null would never come here
> 
>>> +		dev_err(&slave->dev,
>>> +			"address %x needs paging but no support", addr);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	msg->addr_page1 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE1_MASK));
>>> +	msg->addr_page2 = (addr >> SDW_REG_SHIFT(SDW_SCP_ADDRPAGE2_MASK));
>>> +	msg->addr |= BIT(15);
>>> +	msg->page = true;
>>
>> looks ok :-)
> 
> finally !!! yeah the paging and IO code has given me most headache till now!
> 
> 
>>> +int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
>>> +{
>>> +	struct sdw_msg msg;
>>> +	int ret;
>>> +
>>> +	ret = sdw_fill_msg(&msg, slave, addr, count,
>>> +			slave->dev_num, SDW_MSG_FLAG_READ, val);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>
>> ... if you don't test for the slave argument in the sdw_fill_msg but the
>> address is correct then the rest of the code will bomb out.
> 
> I dont think so..

Actually you are right, this makes no sense  to test for a null slave 
because you are already dead.

+int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
+{
+	struct sdw_msg msg;
+	int ret;
+
+	ret = sdw_fill_msg(&msg, slave, addr, count,
+			slave->dev_num, SDW_MSG_FLAG_READ, val);

the dev_num indirection is already killing you.

+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_get_sync(slave->bus->dev);
+	if (!ret)
+		return ret;

> 
>>> +struct sdw_msg {
>>> +	u16 addr;
>>> +	u16 len;
>>> +	u16 dev_num;
>>
>> was there a reason for dev_num with 16 bits - you have 16 values max...
> 
> cant remember, we should use lesser bits though.
> 
>>> +enum sdw_command_response {
>>> +	SDW_CMD_OK = 0,
>>> +	SDW_CMD_IGNORED = 1,
>>> +	SDW_CMD_FAIL = 2,
>>> +	SDW_CMD_TIMEOUT = 4,
>>> +	SDW_CMD_FAIL_OTHER = 8,
>>
>> Humm, I can't recall if/why this is a mask? does it need to be?
> 
> mask, not following!
> 
> Taking a wild guess that you are asking about last error, which is for SW
> errors like malloc fail etc...

no, I was asking why this is declared as if it was used for a bitmask, 
why not 0,1,2,3,4?
