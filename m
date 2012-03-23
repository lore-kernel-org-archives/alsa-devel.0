From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/8] sound:asoc: Add support for STA529
 Audio Codec
Date: Fri, 23 Mar 2012 09:51:42 +0100
Message-ID: <4F6C399E.7090006@metafoo.de>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>	<a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>	<4F68C4F2.5000805@metafoo.de>
	<4F6BF566.8070908@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-024.synserver.de
	[212.40.185.24])
	by alsa0.perex.cz (Postfix) with ESMTP id D1ECF103F4E
	for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2012 10:19:30 +0100 (CET)
In-Reply-To: <4F6BF566.8070908@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, spear-devel <spear-devel@list.st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/23/2012 05:00 AM, Rajeev kumar wrote:
> Hello Lars,
> 
> On 3/20/2012 11:27 PM, Lars-Peter Clausen wrote:
>> On 03/20/2012 12:33 PM, Rajeev Kumar wrote:
>>> +static const char *interface_mode_text[] = { "slave", "master"};
>>
>> Master/slave mode should be configured using the set_dai_fmt callback.
>>
> You mean to say with the help of clock direction. I think you can do it 
> in either way.
> By this,  I am giving full control to user for the selection.

Maybe I'm misunderstanding what this control does. But if it is about
putting the CODEC in master or slave mode, so whether it should generate the
frame- and bitclocks or if the other end of the DAI link should do it, then
this should be configured using set_dai_fmt. Making this runtime selectable
from userspace doesn't make much sense since both sides of the DAI link have
to agree on who is master and who is slave. If you just change one side the
link will just stop working.

>> [...]
>>> +
>>> +static int sta529_i2c_remove(struct i2c_client *client)
>> __devexit
>>> +{
>>> +	snd_soc_unregister_codec(&client->dev);
>>> +	kfree(i2c_get_clientdata(client));
>>> +	return 0;
>>> +}
>> river");
> 
> This comment is not clear to me , please explain.

Annotate the remove function with __devexit. Like this:
+static int __devexit sta529_i2c_remove(struct i2c_client *client)
