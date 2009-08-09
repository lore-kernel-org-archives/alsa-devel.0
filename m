From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Problems with gain controls
Date: Sun, 9 Aug 2009 16:12:20 +0100
Message-ID: <ad2655cb0908090812t21473449q9ff22681138226d9@mail.gmail.com>
References: <ad2655cb0908090328j3e3dff83p68f7d55060590326@mail.gmail.com>
	<1249824410.10398.3.camel@localhost>
	<ad2655cb0908090804g5319ee6awca5250991f498c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214])
	by alsa0.perex.cz (Postfix) with ESMTP id CBE9824338
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 17:12:20 +0200 (CEST)
Received: by fxm10 with SMTP id 10so2443089fxm.45
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 08:12:20 -0700 (PDT)
In-Reply-To: <ad2655cb0908090804g5319ee6awca5250991f498c8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Vroon <tony@linx.net>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2009/8/9 James Courtier-Dutton <james.dutton@gmail.com>:
> 2009/8/9 Tony Vroon <tony@linx.net>:
>> On Sun, 2009-08-09 at 11:28 +0100, James Courtier-Dutton wrote:
>>> pulse seems to do a very bizarre thing. The single master gain control
>>> =A0within pulse changes both the alsamixer PCM and Master controls.
>>
>> That behaviour is by design, and described as a feature here:
>> http://0pointer.de/blog/projects/oh-nine-sixteen.html
>>
>
> Maybe so, but how do I disable it?
> I want pulseaudio doing software volume control, and not touching the
> alsa hardware controls.
> You might ask why I want it disabled, that is because it is a broken
> method. One cannot have a the gain control on the input to a device
> linked to the gain control on the output of a device. If one ever has
> two different inputs, E.g. from the CD, it just messes things up.
> With the current method, all I get is noise from the speakers. If I
> kill pulseaudio, I get nice sound again.
> I don't understand why pulseaudio cannot see how much of a broken idea
> the current method is.
>
I found out how to disable it.
I edited
analog-output.conf.common and changed "merged" to "zero" for the PCM contro=
l.
