From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Can't set 88.2/96kHz samplerate with Hammerfall
Date: Fri, 05 Dec 2003 13:54:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprzpksgt0q1sf88@mail.broadpark.no>
References: <200312042225.hB4MPs6F002813@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312042225.hB4MPs6F002813@oud.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 04 Dec 2003 17:25:53 -0500, Paul Davis=20
<paul@linuxaudiosystems.com> wrote:

>> On Thu, 4 Dec 2003 06:41:56 -0800, Mark Knecht=20
>> <mknecht@controlnet.com>=3D20
>> wrote:
>>
>>>>
>>>> Whenever I try to activate double speed (88.2/96kHz) mode with my RM=
E
>>>> Hammerfall Lite (DIGI 9636), snd_pcm_hw_params fails with a 'Device =
or
>>>> resource busy' message. This is with the number of channels set to 1=
0,
>>>> since the number of ADAT channels is halved. Is this a known
>>>> defect of the
>>>> Hammerfall driver?
>>>>
>>>> Thanks
>>>>
>>>> Arve Knudsen
>>>
>>> From the Hammerfall Light Alsa sound card page:
>>>
>>> Known bugs
>>>
>>> - 96kHz and 88.2kHz not accessible via PCM interface
>> Ok, thanks. I suppose I should've investigated a little better. Too=20
>> bad, =3D
>> I=3D20
>> would like to see this card working as well as under Windows.
>
> to be clear: you can't get DS mode using the PCM interface but you CAN
> (and several people have) do this, you just have to use the control
> interface in addition.
Ah, didn't see your mail untill now. For some reason, you wind up under=20
spam (Opera mail client filter) :\ I suppose I should investigate this=20
possibility.

Thanks

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
