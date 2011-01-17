From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: Sound barely audible since 2.6.37-rc1+
Date: Mon, 17 Jan 2011 22:51:53 +0100
Message-ID: <4D34B9F9.6060606@canonical.com>
References: <AANLkTinpBCweL8cvjaA1m0WpeqSkbXy9ZkNrvbJwXGg6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id AEAC1103803
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 22:51:57 +0100 (CET)
In-Reply-To: <AANLkTinpBCweL8cvjaA1m0WpeqSkbXy9ZkNrvbJwXGg6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Avinash Kurup <kurup.avinash@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2011-01-17 16:24, Avinash Kurup wrote:
> Hi Takashi,
>
> The sound on my computer since 2.6.37-rc1+ is barely audible (extremely
> soft), The sound
> remains the same even on increasing it on the desktop or the application.
>
> On accessing alsa-mixer I get the error, cannot load mixer controls:
> Invalid argument.
>
> I bisected the problem to this commit.
> 03b7a1ab557efe34e8f79b78660e514bd7374248 is the first bad commit
> commit 03b7a1ab557efe34e8f79b78660e514bd7374248

This patch was actually dropped (see 
625787b760b920234ba9736a1ef85297e1bfa110 ) in favour of 
01e0f1378c47947b825eac05c98697ab1be1c86f (ALSA: hda - Fixed ALC887-VD 
initial error).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
