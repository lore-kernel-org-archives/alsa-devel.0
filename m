From: Aldrin Martoq <amartoq@dcc.uchile.cl>
Subject: GIT repo (connection refused)
Date: Tue, 01 Jul 2008 05:18:19 -0400
Message-ID: <1214903899.7099.5.camel@videopodcast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id 0253C2485B
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jul 2008 11:18:25 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so335595and.80
	for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2008 02:18:24 -0700 (PDT)
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

Hello!

http://www.alsa-project.org/main/index.php/GIT_Server#Occasional_Developers

Says but doesn't work:
$ git clone git://git.alsa-project.org/alsa-driver.git alsa-driver 
Initialized empty Git repository in /tmp/alsa-driver/.git/
git.alsa-project.org[0: 212.20.107.51]: errno=Connection refused
fatal: unable to connect a socket (Connection refused)
fetch-pack from 'git://git.alsa-project.org/alsa-driver.git' failed.


Well, this works:
git clone http://git.alsa-project.org/http/alsa-driver.git alsa-driver 


Is this the right repository for submitting patches?


Thanks!

-- 
Aldrin Martoq <amartoq@dcc.uchile.cl>
http://aldrinvideopodcast.podshow.com/
