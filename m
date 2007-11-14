From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: Naming multiple USB devices (solved)
Date: Wed, 14 Nov 2007 13:52:42 +0100
Message-ID: <7c5010d60711140452x170452f5q4a5bd263f3752d39@mail.gmail.com>
References: <7c5010d60711140440s116b2f1cgd0e0302b9f51e66d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 62F462471F
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 13:52:43 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 58so196322wri
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 04:52:42 -0800 (PST)
In-Reply-To: <7c5010d60711140440s116b2f1cgd0e0302b9f51e66d@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi list,

I've added the following script to
http://alsa.opensrc.org/index.php/Udev  (it's not the most elegant
solution, but it works for me):

BEWARE of the linebreaks, they are mangled by the mail client
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
#!/usr/bin/perl
# fixed persistent naming for multiple usb soundcards
# gmaruzz (at) celliax.org

# This is to be executed by udev with the following rules:
# KERNEL=3D=3D"controlC[0-9]*",
DRIVERS=3D=3D"usb",PROGRAM=3D"/usr/bin/alsa_name.pl %k", NAME=3D"snd/%c{1}"
# KERNEL=3D=3D"hwC[D0-9]*", DRIVERS=3D=3D"usb", PROGRAM=3D"/usr/bin/alsa_na=
me.pl
%k", NAME=3D"snd/%c{1}"
# KERNEL=3D=3D"midiC[D0-9]*",
DRIVERS=3D=3D"usb",PROGRAM=3D"/usr/bin/alsa_name.pl %k", NAME=3D"snd/%c{1}"
# KERNEL=3D=3D"pcmC[D0-9cp]*",
DRIVERS=3D=3D"usb",PROGRAM=3D"/usr/bin/alsa_name.pl %k", NAME=3D"snd/%c{1}"

use strict;
use warnings;

my $alsaname =3D $ARGV[0]; #udev called us with this argument (%k)
my $physdevpath =3D $ENV{PHYSDEVPATH}; #udev put this in our environment
my $alsanum =3D "cucu";
#you can find the physdevpath of a device with "udevinfo -a -p
$(udevinfo -q path -n /dev/snd/pcmC0D0c)"


$physdevpath =3D~ s/.*\/([^\/]*)/$1/; #eliminate until last slash
$physdevpath =3D~ s/([^:]*):.*/$1/; #eliminate from twopoint (:) to end_of_=
line

if($physdevpath eq "1-5.2") # you can find this value with "dmesg"
{
       $alsanum=3D"11"; #start from "10" (easier for debugging), "0" is
for motherboard soundcard, max is "31"
}
if($physdevpath eq "1-5.3") # you can find this value with "dmesg"
{
       $alsanum=3D"12"; #start from "10" (easier for debugging), "0" is
for motherboard soundcard, max is "31"
}
if($physdevpath eq "1-5.4") # you can find this value with "dmesg"
{
       $alsanum=3D"13"; #start from "10" (easier for debugging), "0" is
for motherboard soundcard, max is "31"
}
if($physdevpath eq "3-2") # you can find this value with "dmesg"
{
       $alsanum=3D"14"; #start from "10" (easier for debugging), "0" is
for motherboard soundcard, max is "31"
}
# other bus positions....

if($alsanum ne "cucu")
{
       $alsaname=3D~ s/(.*)C([0-9]+)(.*)/$1C$alsanum$3/;
}

print $alsaname;
exit 0;

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Ciao,

Giovanni


On Feb 10, 2007 8:31 PM, Jean-Michel Pour=E9 <jmpoure@free.fr> wrote:
> Le samedi 10 f=E9vrier 2007 =E0 18:53 +0100, Ingo M=FCller a =E9crit :
> > I'm going to play with udev now, too, so if I find something, I'll
> > tell
> > you. In return, it would be awesome if you could write down - even it
> > is
> > only short - a howto about how to manage two identical devices, once
> > we
> > got it working.
> >
>
> Fantastic.
>
> Thank you very much for your help.
> I will add a page on the wiki about udev rules.
>
> Kind regards,
> Jean-Michel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier.
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
