From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: problem while opening device
Date: Tue, 6 Apr 2004 15:15:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404061510560.3153@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA0D82DF50@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA0D82DF50@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: Pavana Sharma <pavans@india.ti.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Apr 2004, Gupta, Kshitij wrote:

> hi Jaroslav,
> 	This file is present.  The only other thing which I wanted to bring
> into your notice is that the file system we are using is a busybox file
> system, with no bash.  Instead it has smaller shell ash.  Will that make a
> difference.

No, ALSA library does not use shell.

> And this file /usr/share/alsa/alsa.conf is only meant to be read ??? 

It contains the definitions for the PCM device names.

> - Is there a way around these aliases "hw:0,0" ....like can;t we open the
> device without this alias ???

hw:0,0 is logical device name for alsa-lib only. The definition for hw
PCM device is stored in the alsa.conf file which should be accessible
for alsa-lib or you have to move the definition in your local ~/.asoundrc 
configuration file.

Also note that you may override the location of this file with 
ALSA_CONFIG_PATH environment variable. For example:

export ALSA_CONFIG_PATH=/etc/alsa/alsa.conf

To include more files:

export ALSA_CONFIG_PATH=/etc/alsa/alsa.conf:/etc/alsa/alsa1.conf

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
