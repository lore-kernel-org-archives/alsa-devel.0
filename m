From: "Alien" <alien999999999@users.sourceforge.net>
Subject: Re: [Openvortex-dev] Re: Re: Volume per voices
     [Feature Request]
Date: Thu, 28 Jul 2005 16:29:55 +0200 (CEST)
Message-ID: <48192.62.59.249.250.1122560995.squirrel@62.59.249.250>
References: <42E889DD.2070808@netvigator.com>
    <Pine.HPX.4.33n.0507280943050.9785-100000@studcom.urz.uni-halle.de>
    <47103.62.59.249.250.1122548343.squirrel@62.59.249.250>
    <21ed1c37050728045725f76ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <21ed1c37050728045725f76ac@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@gmail.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Hi,
>
> On 7/28/05, Maarten Vanraes <maarten.vanraes@telenet.be> wrote:
>> > Raymond wrote:
>> >> There is no need for alsactl to store/restore the values of these
>> kind
>> >> of volume controls.
>> >
>> > Indeed.  Most applications just get the first free substream.
>> > Allowing the user to change 16 (or 32) different volume controls jus=
t
>> > doesn't make sense in this context.
>>
>> maybe an application should only change it's own volume control (not t=
he
>> master volume control); if there is no such thing, it can make it in
>> software.
>
> I totally agree with that. Such a interface should handle not only
> volume (gain) IMHO. There are many other caracteristics that would be
> "very" interesting to make available to applications. Hopefuly one
> should be able to do gain or whatever settings using the PCM device
> handle, without requiring to figure out control names. Just like
> setting hwparams, but something that is possible to do in while the
> PCM device is running. By the way, why cant hwparams be set while the
> PCM device is running ? Many cards support changing samplerate and
> such while running (doppler effect simulation).
>
>> but! shouldn't it also be possible to make an application that can
>> change
>> all these volume controls? like a switchboard or something?
>
> There is a problem with that, because you never know, which
> application is using which subdevice. Even if you know that, many
> application open the PCM device just for the amount of time required
> to do playback/recording. That means that you wont be fast enough
> trying to catch a gain setting with your mouse or keyboard. And for
> the next time a application makes use of a PCM device, it could be a
> different one, and the question arrises, how do you remember the
> setting of a application on a specific device ?
>
> Better let each application handle that kind of controls/settings. If
> they don't do, then its the applications fault.

you have a good point there, but it might be usefull anyway...

at start, show only the ones used at that time, if there are added, add
them; if there are deleted, don't delete them, but remember and hold,
cause if new ones start, these get used anyway, and you can force it on
the newly started application as a default value, if the appl does it
himself, it just gets changed, one could even reset it or deny the appl t=
o
change it...


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO Septem=
ber
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
