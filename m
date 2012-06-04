From: Stephen Warren <swarren@wwwdotorg.org>
Subject: dapm_widget_power_read_file() symmetry issue?
Date: Mon, 04 Jun 2012 16:39:57 -0600
Message-ID: <4FCD393D.3040205@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D0FE243A5
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 00:40:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In dapm_widget_power_read_file(), there is first:

> 	list_for_each_entry(p, &w->sources, list_sink) {
> 		if (p->connected && !p->connected(w, p->sink))
> 			continue;

then right after that:

> 	list_for_each_entry(p, &w->sinks, list_source) {
> 		if (p->connected && !p->connected(w, p->sink))
> 			continue;

Should that last call to p->connected() be p->connected(p->source, w),
since the function's parameters are (source, sink)?
