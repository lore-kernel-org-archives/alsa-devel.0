From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: soc_enum has issues
Date: Wed, 23 Jul 2008 18:00:52 -0400
Message-ID: <9e4733910807231500j69913f5cs5d1479d7ba560de8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 65F5B24825
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 00:00:53 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so458431yxh.2
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 15:00:52 -0700 (PDT)
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

It is treating mask like a max:

dapm_connect_mux...
	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
	int i;

	for (i = 0; i < e->mask; i++) {
		if (!(strcmp(control_name, e->texts[i]))) {

This looks like an error. I don't think there is a requirement that
the number of elements in an enum be a power of two.

-- 
Jon Smirl
jonsmirl@gmail.com
