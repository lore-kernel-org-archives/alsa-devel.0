From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise on snd-hda-intel
Date: Fri, 24 Jun 2011 08:46:32 +0800
Message-ID: <BANLkTimWWvc8t9G91u4f6yUzm4fRAitx0w@mail.gmail.com>
References: <4E00F373.6050001@molgaard.org> <4E00F41E.5090303@molgaard.org>
	<1308691120.6844.1.camel@mattotaupa>
	<4E01A8FA.8060709@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id DD09C246B5
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 02:46:32 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1850016fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2011 17:46:32 -0700 (PDT)
In-Reply-To: <4E01A8FA.8060709@molgaard.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/22 Sune M=F8lgaard <sune@molgaard.org>:

>
> Attached is the generated file.
>
> Best regards,
>
> Sune M=F8lgaard
>

!!Linux Distribution
!!------------------

Ubuntu 11.04 \n \l DISTRIB_ID=3DUbuntu DISTRIB_DESCRIPTION=3D"Ubuntu 11.04"


Is this a clean install of 11.4 or upgrade from previous version of
ubuntu which use "default:2" and create "Digital Capture Volume" ?

since pulseaudio use "front:2" for playback and capture and this won't
create "digital capture volume" control

Do you have any application which use the softvol plugin "PCM Playback Volu=
me" ?

	control.38 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 248
		value.1 249
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -140
			dbvalue.1 -120
		}
	}
	control.39 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 -3000
			dbvalue.1 -3000
		}
