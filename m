From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: kernel-2.5.72: /proc/asound/dev missing
Date: Fri, 20 Jun 2003 15:25:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306201524440.9621-100000@pnote.perex-int.cz>
References: <20030620144322.3afea401.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030620144322.3afea401.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 20 Jun 2003, Maarten de Boer wrote:

> 
> Hello,
> 
> I just upgraded to kernel 2.5.72 (I want to do some LL testing), with the
> alsa driver as included in the kernel. The modules load, but I don't get
> /proc/asound/dev (to which, as I understand, /dev/snd should link). I don't
> use devfs.
> 
> Any suggestions?

You have to rerun snddevices script available in the alsa-driver package 
(utils subdirectory). The dynamic proc devices were removed on request of 
2.5 kernel developers.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
