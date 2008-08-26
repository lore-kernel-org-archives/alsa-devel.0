From: Ash <hashbrown100@hotmail.com>
Subject: Issue with Alsa and PulseAudio
Date: Tue, 26 Aug 2008 08:30:41 +0000
Message-ID: <BAY102-W3417CC50075C3DE003B2F68A660@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s5.bay0.hotmail.com (bay0-omc2-s5.bay0.hotmail.com
	[65.54.246.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 004AB103827
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 10:30:42 +0200 (CEST)
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


Hello,
I have a media application that uses alsa as its sound renderer. It has wor=
ked on numerous systems without any problems until I came across a mandriva=
 distro that bundles with PulseAudio. The alsa pulseaudio plugin is install=
ed correctly, however I am having weird problems.
 =

When I am setting up my hw params, and I call snd_pcm_hw_params_any(), I ge=
t an "Operation not permitted" error. I am not sure why this is happening, =
anyone else see this before? I am using pulseaudio version 0.9.9 and alsa 1=
.0.16.
 =

Thanks in advance!
_________________________________________________________________
Be the filmmaker you always wanted to be=97learn how to burn a DVD with Win=
dows=AE.
http://clk.atdmt.com/MRT/go/108588797/direct/01/
