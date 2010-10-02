From: stan <gryt2@q.com>
Subject: Re: unsupported variant of snd_hda_intel
Date: Sat, 2 Oct 2010 08:18:16 -0700
Message-ID: <BLU0-SMTP1485E34B4CF728168B0A42FEE6A0@phx.gbl>
References: <AANLkTinDxaesb-=AZi8sALtw6MkERjMr3WK7Nixkv06P@mail.gmail.com>
	<AANLkTik3nGq22b0t+f3NMn23CK7x5b+hLJpaW9rjhr0Q@mail.gmail.com>
	<AANLkTikO0QKPO0pfbUj7zJq1Em5v_TWY1b-dZu6VhMPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s25.blu0.hotmail.com (blu0-omc3-s25.blu0.hotmail.com
	[65.55.116.100]) by alsa0.perex.cz (Postfix) with ESMTP id E7FCB24600
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 17:18:25 +0200 (CEST)
In-Reply-To: <AANLkTikO0QKPO0pfbUj7zJq1Em5v_TWY1b-dZu6VhMPA@mail.gmail.com>
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

On Fri, 1 Oct 2010 20:44:58 -1000
Alexandre <alxgomz@gmail.com> wrote:

> How could I test the internal mic by passing pulseaudio?

Install pavuctl, the pulseaudio volume control, and turn off this
device for pulseaudio.  It will then use alsa by default.  You might
have to fiddle with applications to be sure *they* expect to use alsa
instead of pulseaudio as well.
