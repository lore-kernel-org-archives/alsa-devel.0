From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: snd_pcm_info_alloca ( ptr) allocate an INVALID
	snd_pcm_info_t
Date: Fri, 03 Jul 2009 10:22:24 -0300
Message-ID: <4A4E0610.50709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id E06DD248A3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 15:22:38 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1159658qwf.56
	for <alsa-devel@alsa-project.org>; Fri, 03 Jul 2009 06:22:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all!

Mates, I was looking for a reasonable explanation on why the functions 
*_alloca as snd_pcm_info_alloca allocates an INVALID snd_pcm_info_t??

At my point of view this function reserves memory for the allocation of 
snd_pcm_info_t and so it is a real space reservation.


I don't want get a wrong understanding and as long as there is no 
information regarding this, I am here asking!

Thanks in advanced!
