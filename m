From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: SoC: Added jack detection kcontrol
 support
Date: Wed, 24 Jul 2013 08:16:57 +0200
Message-ID: <51EF7159.8030409@canonical.com>
References: <1374281962-3786-1-git-send-email-eu@felipetonello.com>
 <20130722000157.GI9858@sirena.org.uk>
 <CAGrhNMyAofsnwKYMk+60GyvpaW9pMtoJf_2Q_Tc82G8QCFOiFA@mail.gmail.com>
 <20130723124023.GX9858@sirena.org.uk>
 <CAGrhNMyWXGcDUHxexgvQ2rusKTSbSjEbcEToKZZUudtP-pYxsA@mail.gmail.com>
 <20130724001332.GW9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C78C2260863
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 08:17:01 +0200 (CEST)
In-Reply-To: <20130724001332.GW9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Felipe Tonello <eu@felipetonello.com>, "Felipe F. Tonello" <ftonello@cercacor.com>, TakashiIwaitiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, JaroslavKyselaperex@perex.cz
List-Id: alsa-devel@alsa-project.org

On 07/24/2013 02:13 AM, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 05:10:29PM -0700, Felipe Tonello wrote:
>> On Tue, Jul 23, 2013 at 5:40 AM, Mark Brown <broonie@kernel.org> wrote:
>
>>> This was the existing kernel API at the time that the code was added -
>>> I beleive people had been doing that for simple switches that detect the
>>> physical presence of a jack since it looks exactly like a button from a
>>> hardware point of view.  See the original commit adding the code.
>
>> I saw it. I don't know what you think is the best way to go. I'm not
>> sure if someone is using this input event API, since even PulseAudio
>> even declined that implementation due KControl implementation.
>
> It's used quite a bit in embedded systems, there are actually patches
> for PulseAudio which were deployed for a while- I guess they might have
> been removed or something.

The input event implementation was only in Ubuntu (for a release or 
two), and was never merged in upstream PA. (I guess one could find them 
by looking in the Ubuntu archives.)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
