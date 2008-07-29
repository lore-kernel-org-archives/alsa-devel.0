From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: multiple identical controls
Date: Tue, 29 Jul 2008 19:36:13 -0400
Message-ID: <9e4733910807291636q34148c2br357e986cddaa37e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B692103821
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 01:36:14 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so26867qwj.56
	for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2008 16:36:13 -0700 (PDT)
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
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My hardware has four channels, each with seven identical biquads.
I'm making a custom control to handle them.

Don't I want to give then an index from 0 to 6?
Why is snd_soc_cnew() setting index to zero?

struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
	void *data, char *long_name)
{
	struct snd_kcontrol_new template;

	memcpy(&template, _template, sizeof(template));
	if (long_name)
		template.name = long_name;
	template.index = 0;

	return snd_ctl_new1(&template, data);
}
EXPORT_SYMBOL_GPL(snd_soc_cnew);
-- 
Jon Smirl
jonsmirl@gmail.com
