From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Best default values for "External Amplifier" and
 "Audigy Analog/Digital Output Jack"
Date: Mon, 19 Sep 2005 20:35:15 +0100
Message-ID: <432F12F3.3030405@superbug.co.uk>
References: <432D290E.4010506@yahoo.co.uk> <432D5312.1000506@superbug.co.uk>	<432E6D40.7080904@yahoo.co.uk> <8564sxh10w.fsf@Orfeo.duckcorp.org>	<m264sxutnl.fsf@vador.mandriva.com> <85hdchfcih.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <85hdchfcih.fsf@Orfeo.duckcorp.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
Cc: Thierry Vignaud <tvignaud@mandriva.com>, Thomas Hood <jdthood@yahoo.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Arnaud Patard (Rtp) wrote:
> Thierry Vignaud <tvignaud@mandriva.com> writes:
> 
> 
>>Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:
>>
>>
>>>AFAIK, the behaviour of the switch is consistent accross all the
>>>audigy cards. If you're using Digital Speakers connected to the
>>>digital output of the card, you have to set it. Otherwise, don't set
>>>it. It's setup dependant. IMHO you can't do anything about that. [
>>>IIRC, even the OSS driver has this 'problem'. ]
>>
>>some drivers have a sense mixer element.
>>
>>cannot more drivers be patched in order to have such a behavior (if
>>possible)?
> 
> 
> At least, on the audigy player/gamer, the connector used for the digital out is
> also used for analog out (see
> http://fr.europe.creative.com/support/downloads/download2.asp?manualID=807&Product_ID=237&regionID=3&Product_Name=Audigy+Gamer)
> . Thus detecting if there's a cable connected or not to set the 'Audigy
> Analog/Digital Output Jack' switch won't work.
> 
> 
> Regards,
> Arnaud
> 

This sounds like we need to add an extra configuration that the user can 
do with the help of a simple command line or GUI tool.
This extra user supplied information will be "speaker arrangement".
I suggested this a long time ago, but never got round to deciding how 
best to do it. Maybe a new mixer control element that is present 
irrespective of the sound card being used, and that can also be read by 
the driver to configure itself.
The driver would present somehow to the GUI app the range of options the 
user has, and the user would then simply select the option they are using.
e.g.
1) SPDIF digital output
2) 5.1 Surround sound.
3) ... etc.

After selecting the option they think is right, there would be a simple 
click button saying "test" at which point it tries sending some sound 
out of the speakers.

We must, in all cases, identify which features are bugs in the drivers, 
and which have to be implemented as user space applications.

The "External Amplifier" setting is a driver bug, but requires special 
case quirks for each and every different sound card using the same sound 
chip. This setting should default to getting sound from the speakers, 
and not from the headphones.

The "Audigy Analog/Digital Output Jack" is directly related to 
"speaker-arrangement" as a single jack is shared between being an analog 
lfe/center speaker jack, and a spdif digital output jack.

The "External Amplifier" is only half the problem. There are 
motherboards with sound chips that if we send sound to the "front" 
channels nothing comes from the speakers on laptop A, but it works fine 
for laptop B. It turns out that sending sound to the "center/lfe" 
actually produces sound from the "front" speakers on laptop A.

So, in summary, instead of each distribution trying to write work 
arounds and scripts to get over the problem, they should in fact be 
raising bug reports with the alsa bug tracking system, so that they can 
be fixed.

I think that maybe there should be a kernel module option to get the 
sound cards to default to either "mute" or "50%" sound levels.
Then no scripts would be needed, and only a single module option would 
fix the problem for everybody.

So, please everybody, help us fix the problems instead of trying all 
sorts of workarounds!!!

James


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
