From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA server upgrade
Date: Tue, 17 Jul 2012 19:34:35 +0200
Message-ID: <5005A22B.4060502@perex.cz>
References: <5003D896.3080606@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 284B126520B
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 19:33:34 +0200 (CEST)
Received: from server.perex.cz (unknown [172.16.0.20])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3E6E414991C
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 18:11:53 +0200 (CEST)
Received: from t510.perex-int.cz (localhost [127.0.0.1])
 by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id 28A89844B5
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 18:11:50 +0200 (CEST)
In-Reply-To: <5003D896.3080606@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 16.7.2012 11:02, Jaroslav Kysela wrote:
> Hello,
> 
> 	I will do the complete ALSA server upgrade in next days. It means that
> all services may be affected for some time (the devel mailing list, web
> server, ftp server, GIT server).

	The main configuration fighting is finished. Most problems were caused
by SELinux, the migration from gitosys to gitolite and the MediaWiki
upgrade.
	Web server, GIT server, FTP server, tar ball snapshots, mailing lists
are working.
	The mantis bugtracking system is not available at this moment.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
