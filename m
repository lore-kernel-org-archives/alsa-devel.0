From: "John L. Utz III" <john.utz@dmx.com>
Subject: git clone alsa-driver behind a firewall?
Date: Fri, 01 Aug 2008 14:54:15 -0700
Message-ID: <op.ue79spew647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id E9D3F2451A
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 23:54:25 +0200 (CEST)
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

Hi guys;

I am trying to re-sync so that i can try to get my vt1618 stuff into alsa  
that got rejected last year.

But since my last attempted patch, alsa's moved from hg to git and i cant  
seem to clone the repository.


jutz@jutz-gnto64 ~/Compile/AlsaDev $ git clone  
git://git.alsa-project.org/alsa-driver.git alsa-driver
Initialized empty Git repository in  
/home/jutz/Compile/AlsaDev/alsa-driver/.git/
git.alsa-project.org[0: 212.20.107.51]: errno=Connection timed out
fatal: unable to connect a socket (Connection timed out)
fetch-pack from 'git://git.alsa-project.org/alsa-driver.git' failed.


am i correct in assuming that git runs on a port that a diligent admin  
would not have open by default?

tnx!

johnu
