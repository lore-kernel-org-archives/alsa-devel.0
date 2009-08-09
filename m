From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: Problems with gain controls
Date: Sun, 9 Aug 2009 16:04:18 +0100
Message-ID: <ad2655cb0908090804g5319ee6awca5250991f498c8@mail.gmail.com>
References: <ad2655cb0908090328j3e3dff83p68f7d55060590326@mail.gmail.com>
	<1249824410.10398.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A3BA103817
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Aug 2009 17:04:19 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 13so309893fge.21
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 08:04:18 -0700 (PDT)
In-Reply-To: <1249824410.10398.3.camel@localhost>
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

2009/8/9 Tony Vroon <tony@linx.net>:
> On Sun, 2009-08-09 at 11:28 +0100, James Courtier-Dutton wrote:
>> pulse seems to do a very bizarre thing. The single master gain control
>> =A0within pulse changes both the alsamixer PCM and Master controls.
>
> That behaviour is by design, and described as a feature here:
> http://0pointer.de/blog/projects/oh-nine-sixteen.html
>

Maybe so, but how do I disable it?
I want pulseaudio doing software volume control, and not touching the
alsa hardware controls.
You might ask why I want it disabled, that is because it is a broken
method. One cannot have a the gain control on the input to a device
linked to the gain control on the output of a device. If one ever has
two different inputs, E.g. from the CD, it just messes things up.
With the current method, all I get is noise from the speakers. If I
kill pulseaudio, I get nice sound again.
I don't understand why pulseaudio cannot see how much of a broken idea
the current method is.

Kind Regards

James
