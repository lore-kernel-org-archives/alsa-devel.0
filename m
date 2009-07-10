From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: runtime->boundary
Date: Fri, 10 Jul 2009 12:00:09 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BC87F67@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DFA6244B3
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 08:30:39 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Can anyone help explain what is runtime->boundary and what is the value that is set for this? It seems to be a pretty huge value when I try and print it.

Also in snd_pcm_indiret_capture_transfer, I see this code snippet;


If (diff < runtime->boundary /2)
	diff += runtime->boundary

what is the reason for the same? If its for handling ring buffer wrapping, should I be setting my runtime->boundary to rumtime->buffer_size in the driver code?

Thanks,
Harsha
