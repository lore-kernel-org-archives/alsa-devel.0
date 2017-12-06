From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v4 06/15] soundwire: Add IO transfer
Date: Wed, 6 Dec 2017 11:28:15 +0530
Message-ID: <20171206055813.GO32417@localhost>
References: <1512122177-2889-1-git-send-email-vinod.koul@intel.com>
 <1512122177-2889-7-git-send-email-vinod.koul@intel.com>
 <40d00228-2891-6e25-4c6f-789518a0e2c2@linux.intel.com>
 <20171203170418.GN32417@localhost>
 <d7ed6ffa-e9b3-a7c9-ae07-369d2d541eab@linux.intel.com>
 <20171205063114.GL32417@localhost>
 <fb78b1c5-0a52-90b3-262e-8880aeb2da11@linux.intel.com>
 <6a475ed4-8ca5-0422-e416-2a32f1afa8ef@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a475ed4-8ca5-0422-e416-2a32f1afa8ef@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Sagar Dharia <sdharia@codeaurora.org>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Sudheer Papothi <spapothi@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 05, 2017 at 08:48:03AM -0600, Pierre-Louis Bossart wrote:
> On 12/5/17 7:43 AM, Pierre-Louis Bossart wrote:
> >On 12/5/17 12:31 AM, Vinod Koul wrote:
> >>On Sun, Dec 03, 2017 at 09:01:41PM -0600, Pierre-Louis Bossart wrote:

> >>>>>>+static inline int do_transfer(struct sdw_bus *bus, struct
> >>>>>>sdw_msg *msg)
> >>>>>>+{
> >>>>>>+    int retry = bus->prop.err_threshold;
> >>>>>>+    enum sdw_command_response resp;
> >>>>>>+    int ret = 0, i;
> >>>>>>+
> >>>>>>+    for (i = 0; i <= retry; i++) {
> >>>>>>+        resp = bus->ops->xfer_msg(bus, msg);
> >>>>>>+        ret = find_response_code(resp);
> >>>>>>+
> >>>>>>+        /* if cmd is ok or ignored return */
> >>>>>>+        if (ret == 0 || ret == -ENODATA)
> >>>>>
> >>>>>Can you document why you don't retry on a CMD_IGNORED? I know
> >>>>>there was a
> >>>>>reason, I just can't remember it.
> >>>>
> >>>>CMD_IGNORED can be okay on broadcast. User of this API can retry all
> >>>>they
> >>>>want!
> >>>
> >>>So you retry if this is a CMD_FAILED but let higher levels retry for
> >>>CMD_IGNORED, sorry I don't see the logic.
> >>
> >>Yes that is right.
> >>
> >>If I am doing a broadcast read, lets say for Device Id registers, why in
> >>the
> >>world would I want to retry? CMD_IGNORED is a valid response and
> >>required to
> >>stop enumeration cycle in that case.

Above is the clarfication

> >>But if I am not expecting a CMD_IGNORED response, I can very well go
> >>ahead
> >>and retry from caller. The context is with caller and they can choose to
> >>do
> >>appropriate handling.
> >>
> >>And I have clarified this couple of times to you already, not sure how
> >>many
> >>more times I would have to do that.
> >
> >Until you clarify what you are doing.

Let me try again, I think u missed that part of my reply above

If I am doing a broadcast read, lets say for Device Id registers,
why in the world would I want to retry? CMD_IGNORED is a valid response
and required to stop enumeration cycle in that case.

> >There is ONE case where IGNORED is a valid answer (reading the Prepare not
> >finished bits), and it should not only be documented but analyzed in more
> >details.
> I meant Read SCP_DevID registers from Device0... prepare bits should never
> return a CMD_IGNORED

Precisely as I pointed out above.

> >For a write an IGNORED is never OK.

Agreed, but then transfer does both read and write. Write call can treat it
as error and read call leaves it upto caller.

Does that sound okay for you?

-- 
~Vinod
