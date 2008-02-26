From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: POLLIN and POLLOUT event in pcm io plugins
Date: Mon, 25 Feb 2008 18:22:16 -0800
Message-ID: <61445c750802251822o552217em4acd3684d671559b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id CAAAF103839
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 03:22:18 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so1936394wag.8
	for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2008 18:22:17 -0800 (PST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

The structure  snd_pcm_ioplug has following members:

int poll_fd; /**< poll file descriptor */
unsigned int poll_events; /**< poll events */

and the associated events are POLLIN and POLLOUT, I suppose. I am
unable to understand how
these fields are getting used. There are many other plugins which dont
use this. What is the
significance of these fields?

-pharaoh.
