From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: [linux-audio-user] emu10k1 multichannel support
Date: Mon, 31 Jan 2005 20:53:46 +1100
Message-ID: <41FE002A.1070807@machinehasnoagenda.com>
References: <1106091638.30792.3.camel@krustophenia.net>	<200501302354.58104.arnold@roederberg.dyndns.org>	<41FD8252.2070507@machinehasnoagenda.com> <1107134518.32117.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1107134518.32117.7.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Mon, 2005-01-31 at 11:56 +1100, Shayne O'Connor wrote:
>  
>
>>using "Playback Only", i am able to get down to 64 frames/periods when
>>using Mixxx - got a couple of xruns in a half-hour session (this was
>>with network running azureus and some other stuff).
>>
>>not sure if you're aware, but the latest patch is this one:
>>
>>http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v007.patch
>>
>>    
>>
>
>Actually I just remembered I posted a newer version.  This connects the
>external inputs to the multichannel capture device.  The JACK capture
>ports should correspond exactly to the default kX ASIO capture channels
>(1,2 is Line/Mic, 9,10 is Line2/Mic2, etc),  You can record from all
>inputs at once, so with a LiveDrive you can record 4 or 6 analog inputs.
>
>http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v008.patch
>
>  
>
i'm sure i applied the patch correctly, but does this get rid of the
following problem? :

>The last version I posted had a stupid bug where it captured
>the 16 FX buses instead of the 16 external inputs like I had intended.
>So you could only capture what you were playing back.
>
(btw - with this patch, i'm sure i've always been able to record from
the inputs *and* playback - the only problem is seperating the two so as
to only record the inputs through the ac97 codec, and not the playback
as well)

>>i'm not sure if this fixes the wavetabel synth, though - i still can't
>>get any sounds from the sb live onboard synth .... i'm gonna report back
>>to lee on the alsa-devel list, as that is probly the best place for
>>testing results, bug reports etc ...
>>    
>>
>
>This is the first I have heard of it.  The wavetable problem should have
>been fixed a while ago.  Please report it on alsa-devel.
>  
>
my boo-boo - somewhere along the way my sfxload script got knocked out
of commission ... all is good now :)

shayne

ps - i'm sending this to alsa-devel as well, as it is probly more
appropriate there?


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
