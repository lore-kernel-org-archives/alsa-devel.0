From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: au88x0 modem
Date: Fri, 16 Sep 2005 16:49:07 +0200
Message-ID: <20050916144907.GA2454@titan.lahn.de>
References: <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de> <432A8887.4020808@netvigator.com> <20050916103604.GA3168@titan.lahn.de> <432AB4B1.1050808@netvigator.com> <20050916144247.GA2425@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050916144247.GA2425@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

On Fri, Sep 16, 2005 at 04:42:47PM +0200, Philipp Matthias Hahn wrote:
> Looks like I lost the normal ac97#1-1* files in
> /proc/asound/card0/codec97#0:
> 	$ ls /proc/asound/card0/codec97#0/
> 	mc97#1-1  mc97#1-1+regs

Worse, two times the directories "codec97#0" with the same name:

	$ ls -l /proc/asound/card0
	total 0
	dr-xr-xr-x   2 root root 0 2005-09-16 16:48 codec97#0
	dr-xr-xr-x   2 root root 0 2005-09-16 16:48 codec97#0
	-r--r--r--   1 root root 0 2005-09-16 16:48 id
	-r--r--r--   1 root root 0 2005-09-16 16:48 midi0
	-rw-r--r--   1 root root 0 2005-09-16 16:48 oss_mixer
	dr-xr-xr-x  18 root root 0 2005-09-16 16:48 pcm0c
	dr-xr-xr-x  18 root root 0 2005-09-16 16:48 pcm0p
	dr-xr-xr-x   3 root root 0 2005-09-16 16:48 pcm1p
	dr-xr-xr-x  18 root root 0 2005-09-16 16:48 pcm2p
	dr-xr-xr-x   3 root root 0 2005-09-16 16:48 pcm4p

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
