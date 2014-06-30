From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - alsa-utils 4/5] Documentation manual page
 for amidicat
Date: Mon, 30 Jun 2014 13:32:52 +0200
Message-ID: <53B14AE4.20008@ladisch.de>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-5-git-send-email-alsa@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
 [80.67.31.30]) by alsa0.perex.cz (Postfix) with ESMTP id 7A9DC26537E
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 13:32:55 +0200 (CEST)
In-Reply-To: <1404118503-22921-5-git-send-email-alsa@krellan.com>
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
> +++ b/amidicat/amidicat.1
> +.\" Generator: DocBook XSL Stylesheets v1.75.2 <http://docbook.sf.net/>

So this is not the actual source code?

> +\fB\-\-hex\fR
> ...
> +If this option is not given, the default is raw binary data\&.

This is the only place in the documentation where the default input/
output format is described.  Please move it to a more prominent
location.


Regards,
Clemens
