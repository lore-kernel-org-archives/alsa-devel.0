From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: Re: [linux-audio-user] emu10k1 multichannel support
Date: Wed, 02 Feb 2005 21:50:32 +1100
Message-ID: <4200B078.9070006@machinehasnoagenda.com>
References: <1106091638.30792.3.camel@krustophenia.net>	<200501302354.58104.arnold@roederberg.dyndns.org>	<41FD8252.2070507@machinehasnoagenda.com> <1107134518.32117.7.camel@krustophenia.net> <41FE002A.1070807@machinehasnoagenda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
In-Reply-To: <41FE002A.1070807@machinehasnoagenda.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Shayne O'Connor wrote:

>i'm sure i applied the patch correctly, but does this get rid of the
>following problem? :
>
>  
>
>>The last version I posted had a stupid bug where it captured
>>the 16 FX buses instead of the 16 external inputs like I had intended.
>>So you could only capture what you were playing back.
>>
>>    
>>
>(btw - with this patch, i'm sure i've always been able to record from
>the inputs *and* playback - the only problem is seperating the two so as
>to only record the inputs through the ac97 codec, and not the playback
>as well)
>  
>

ok - i've figured out what i need to do ... (i use qamix as my mixer ...
least confusing for me ... so i'm using that as my reference here):

1) in the "playback" tab of qamix, there are 3 sections - "master",
"stereo", and "surround". in the "stereo" section, there are volume
sliders for "pcm", "wave", and "music". leave the "pcm" and "music"
sliders at a suitable playback level, and set the "wave" slider to "0".

yep - that's all i needed to do, and i can now record extra tracks into
ardour without the previously recorded tracks being merged in.

as you can probably tell, i don't really have any idea what the
difference between "pcm" and "wave" volume is ... all i know is that if
i use the default device - "hw:0,0" -  then it makes no effect on the
recorded input if the "wave" volume is up or not ... i guess the
difference is the result of your patch :)

anyways, i guess that makes this patch my default alsa driver now, heh,
heh ...

brilliant, brilliant work lee!!

shayne


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
