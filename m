From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - alsa-utils 1/5] Adding amidicat
 subdirectory to SUBDIRS
Date: Mon, 30 Jun 2014 13:32:42 +0200
Message-ID: <53B14ADA.50202@ladisch.de>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-2-git-send-email-alsa@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de
 [80.67.29.23]) by alsa0.perex.cz (Postfix) with ESMTP id D4E28265119
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 13:32:43 +0200 (CEST)
In-Reply-To: <1404118503-22921-2-git-send-email-alsa@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Josh Lehan <alsa@krellan.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Josh Lehan wrote:
> +++ b/Makefile.am
> -SUBDIRS = include alsactl alsaucm utils m4 po
> +SUBDIRS = include alsactl alsaucm utils m4 po amidicat

This belongs into the seq directory.


Regards,
Clemens
