From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [PATCH alsa-lib 2/2] pcm_plugin: Fix return value
 of snd_pcm_rewind
Date: Wed, 26 Jun 2013 12:06:47 +0530
Message-ID: <1372228607.4981.15.camel@localhost>
References: <1369909594-15047-1-git-send-email-david.henningsson@canonical.com>
 <1369909594-15047-2-git-send-email-david.henningsson@canonical.com>
 <51A7408C.1010608@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id A1AA42625D8
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2013 11:02:47 +0200 (CEST)
In-Reply-To: <51A7408C.1010608@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-05-30 at 14:05 +0200, Jaroslav Kysela wrote:
> Date 30.5.2013 12:26, David Henningsson wrote:
> > In case the rewind did not rewind as much as expected, e g due to
> > time delay between the latest avail update and the rewind, we must
> > properly account for that in the plugin layer.
> 
> Thank you very much for this fix.
> I applied both patches to alsa-lib's repo.

Could we get a release with these patches? This does bite people a bit.

-- Arun
