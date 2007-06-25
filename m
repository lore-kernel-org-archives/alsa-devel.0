From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: No sound on Medion laptop (intel 82801G)
Date: Sun, 24 Jun 2007 21:00:31 -0700
Message-ID: <1182744031.24812.73.camel@razman.gruemaster.com>
References: <1182742038.467f361683784@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id F113E24420
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 06:00:35 +0200 (CEST)
In-Reply-To: <1182742038.467f361683784@imp.free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: albox@free.fr
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could you try reloading the driver with "rmmod snd-hda-intel && modprobe
snd-hda-intel probe_mask=1".  t looks like the modem is getting in the
way, which has been happening lately (not sure why).

I'm reviewing the patch I sent you back in October against the current
code to see if there are any anomalies.

Tobin

On Mon, 2007-06-25 at 05:27 +0200, albox@free.fr wrote:

> Hi,
> I reported a bug about medion laptops having an intel 82801G sound card that
> doesn't work with ALSA 1.0.14rc4 on Kubuntu :
> https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=3160
> I didn't get any news yet. As I said, I'm willing to help. Any ideas about what
> I should check ? Is there any web page that could help me to detect the problem
> ?
> 
> Thanks
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
