From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: SPDIF rate setting.
Date: Sat, 18 Sep 2004 21:02:00 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095555720.2290.10.camel@localhost>
References: <414B4245.50600@superbug.co.uk>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <414B4245.50600@superbug.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi James,

On Fri, 2004-09-17 at 16:00, James Courtier-Dutton wrote:
> It seems that more and more people are using SPDIF digital output at 
> 44.1khz. E.g. DTS tracks on CDs.
> Currently, people are having to manually change the SPDIF rate setting 
> using iecset or the application is having to play with AES3 in the 
> "iec958:AES..." at device open.
> How about, when someone opened the device "iec958" and then uses 
> snd_pcm_hw_params_set_rate(), it should automatically set the iecset 
> rate to equal the rate set by the set_rate function call.
> 
> Any comments?

There is a problem with that, because you are confusing output
samplerate with the application data samplerate. The
snd_pcm_hw_params_set_rate() is set according to the intended sample
rate an application writes to a PCM device, but the samplerate of the
SPDIF stream must be accordning to the external decoder you are using.
If both are different, a soundcard may use some hardware samplerate
converter to cope with that, or just set restriction which allow only
the samplerate suitable to the decoder.

As i have mentioned some tiome ago, i thing there should be some sort of
output device configuration, as an instance to collect and manage the
information of what the Hell is conected to the output jacks of the
users soundcard, and do some software management automatically according
to that. That would allow us to do automatic 5.1 to stereo downmix,
stereo to 5.1 upmix, format output correctly in case of SPDIF output,
arrange channels according to the speaker layout, etc.

Best Regards

Manuel Jander




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
