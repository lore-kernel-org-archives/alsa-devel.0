From: rohith R <rohith.ubuntu@gmail.com>
Subject: question on Asoc tlv320aic3104
Date: Tue, 28 Feb 2012 18:15:37 +1030
Message-ID: <CAJnYUCT_2Ga7eefnWMVYmUw=jMLmqReXUpcYjyeQXA1prk5kKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id E91A4244BB
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 08:45:37 +0100 (CET)
Received: by laap9 with SMTP id p9so3061121laa.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 23:45:37 -0800 (PST)
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
I'm modifying Asoc tlv320aic3104 codec driver to support MIC3L/R
inputs(currently not supported in the code.)
I'm a newbie to ALSA programming and had these questions:

1.Is there any documentation for ASOC apart from the one in kernel sources?
2.ALSA api reference guide link on the website is giving a 404 error.Any
updated link?
3.Trying to program Page0 register17/18 to add as a  "route".Which is the
best way to do it.Still new to the range of SOC_**   #defines available.

--Rohith
