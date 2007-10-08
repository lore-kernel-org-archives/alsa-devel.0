From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: How to get set/fixed sample rate of ALSA device?
Date: Mon, 08 Oct 2007 21:30:42 +0200
Message-ID: <470A8562.50301@keyaccess.nl>
References: <b97f4ee40710061456l5aa0764alce22c505401c7e6f@mail.gmail.com>
	<4708F918.3060207@keyaccess.nl>
	<b97f4ee40710071004o23ea40a1w8c8f754b47083b95@mail.gmail.com>
	<470958A9.7040607@keyaccess.nl>
	<b97f4ee40710081209k1ba59df3g491387b681f8bbe3@mail.gmail.com>
	<Pine.LNX.4.64.0710081212360.32693@info.physics.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0710081212360.32693@info.physics.ubc.ca>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Bill Unruh <unruh@physics.ubc.ca>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/08/2007 09:14 PM, Bill Unruh wrote:

> On Mon, 8 Oct 2007, Peteris Krisjanis wrote:
> 
>>> Introducing a /proc/asound/card0/pcm0{p,c}/hw_limits or similar might
>>>  not be a bad idea though?
>> 
>> That would be good idea, with completion with 'alsainfo' about device.
>> 
>> How to do that properly, any clues before I try to sink my teeths in 
>> ALSA code?
> 
> Is this even possible? Ie, do sound cards actually tell you what their
> max or min hardware capabilities are and what info might you put into
> here? Ie, some cards can do 2 or 4 or 5.1 channel output. Do you put that
> in? And re speed, does the card actually advertise what speeds it
> supports, or is it more a matter of trying and if it does not support it,
> it rejects it.

It's really only about communicating what the _driver_ accepts (ie, tells us 
the hardware can do). That is, basically export the snd_pcm_hardware struct 
for the stream.

It could also be done in userspace by opening the stream and quering the 
format_mask, channels and rates and stuff and I'll look into that a bit as a 
followup to the rates_min/max thing that I posted if only as a template 
thingy, but unless I'm missing it, I don't believe there's actually a way to 
get the information from userspace without opening the "hw" device, and that 
one only allows "subdevices_count" concurrent opens, meaning you'd have to 
stop things talking to your soundcard if it has just one (normal).

Exposing it directly in /proc/asound would be the way. Peteris; if you'll be 
looking, note that rates (and channels) might not be continuous between 
their min and max or anything; mostly it's enumerated stuff. Looking at the 
/proc/asound/card0/pcm0p/sub0/hw_params file generation probably helps (but 
that just exports the currently selected paramters, not all possible).

Rene.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
