From: "Rahul Ramasubramanian" <ramasubramanian.rahul@gmail.com>
Subject: problems in building with DOXYGEN defined
Date: Thu, 17 Jul 2008 15:25:09 +0530
Message-ID: <16ada07b0807170255g6aa6714ajd452288bd39c1084@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by alsa0.perex.cz (Postfix) with ESMTP id F3848243A0
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 11:55:10 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so4804643rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2008 02:55:09 -0700 (PDT)
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

hi
i want to build alsa-lib-1.0.15 with DOXYGEN defined ..
i read in the docs that if i add DOXYGEN to the PREDFINED field of
doxygen.cfg , it is as good as doing a gcc -DDOXYGEN
but after building it with the above option , i see that DOXYGEN  still
remains undefined , consequently , when i try to build alsa-utils-1.0.15 ,
it breaks in alsactl/name.c because it cant find the defination of function
snd_timer_query_internal. This happens because the function is declared
differenlty if DOXYGEN is not defined (timer_query.c).
please help me in this
Kind regards
Rahul
