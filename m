From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - oxygen 1/1] Patch for the Xonar DG Patch
 by Roman Volkov
Date: Tue, 03 Dec 2013 17:05:43 +0100
Message-ID: <529E0157.4050807@ladisch.de>
References: <1386085561-20131-1-git-send-email-alsa@mgraefe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E0C13261A1B
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 17:05:52 +0100 (CET)
In-Reply-To: <1386085561-20131-1-git-send-email-alsa@mgraefe.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marius Graefe <alsa@mgraefe.de>
Cc: alsa-devel@alsa-project.org, v1ron@mail.ru
List-Id: alsa-devel@alsa-project.org

Marius Graefe wrote:
> 2) I had to assign a .shortname in xonar_dg_model, otherwise my kernel
> (unmodified ubuntu 3.2.0-56-generic-pae) throws an oops, the backtrace
> led me to the missing string.

What code tries to access the shortname?  What is the backtrace?


Regards,
Clemens
