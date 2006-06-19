From: Glen Masgai <mimosius@gmx.de>
Subject: Re: [ALSA - driver 0002159]: ac3 passthrough not
 working on recent versions
Date: Mon, 19 Jun 2006 19:00:39 +0200
Message-ID: <4496D837.9070609@gmx.de>
References: <9bf77025a623d4cebd0491303f7f6f65@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <9bf77025a623d4cebd0491303f7f6f65@bugtrack.alsa-project.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

I already tried this "rear_swap=1" but AC3-passthrough doesn't work, so
there must be another bug which breaks it.


bugtrack@alsa-project.org schrieb:
> The following issue has been RESOLVED.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
> ======================================================================
> Reported By:                nikke
> Assigned To:                Clemens Ladisch
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   2159
> Category:                   PCI - ymfpci
> Reproducibility:            always
> Severity:                   minor
> Priority:                   normal
> Status:                     resolved
> Distribution:               Debian
> Kernel Version:             2.6.15
> Resolution:                 not fixable
> Fixed in Version:           
> ======================================================================
> Date Submitted:             05-24-2006 23:44 CEST
> Last Modified:              06-19-2006 13:33 CEST
> ======================================================================
> Summary:                    ac3 passthrough not working on recent versions
> Description: 
> Using the following AC3 passthrough with mplayer works:
> Linux 2.4.31
> alsa-driver 1.0.8-7 (debian stable packaged)
>
> Using Linux 2.6.15 (both with alsa-driver 1.10rc3 that ships with the
> kernel and
> alsa-driver 1.0.11) it doesn't work. The reciever just says "unlock" and
> stays quiet.
>
> The only change is booting with different kernels, no other config or
> hardware is touched, so this must be a driver regression.
>
> The card is YMF-754 based, connected with coax spdif to my HK reciever.
>
> If you need more info, just tell me and I'll dig it up.
> ======================================================================
>
> ----------------------------------------------------------------------
>  Raymond - 06-18-06 13:30 
> ----------------------------------------------------------------------
> I don't have this card, you better wait Clemens Ladisch's review.
>
> BTW, Is there any reason why dsnoop is not eanbled ?
>
> The volume per voice feature is hard to use, especially when different
> drivers implement this feature in different ways
> 1) emu10k1 - use index
> 2) ymfpci  - use subdevice
>
> Can any of you try speaker-test -Dsurround40 -c 4 -t wav  ?
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2026
>
>
>
> ----------------------------------------------------------------------
>  Clemens Ladisch - 06-19-06 13:33 
> ----------------------------------------------------------------------
> My patch indeed broke AC3 passthrough.  However, it fixed the incorrect
> channel routing of the rear analog output.
>
> The problem of the swapped rear channels is a bug in either the hardware
> or in the firmware Yamaha provided to us, so the driver has to work around
> it by swapping the rear channels before playing them.  The rear channels
> are a resource shared between the rear analog output and the digital
> output, so the channel swapping workaround affects both outputs (although
> the bug itself affects only the analog output).
>
> A later patch added the rear_swap module option so that the user can
> choose which one of the outputs is right.  Use "rear_swap=1" to get
> correct AC3 output.
> (This module option probably should be a mixer option.)
>
> Issue History
> Date Modified  Username       Field                    Change              
> ======================================================================
> 05-24-06 23:44 nikke          New Issue                                    
> 05-24-06 23:44 nikke          Distribution              => Debian          
> 05-24-06 23:44 nikke          Kernel Version            => 2.6.15          
> 05-24-06 23:47 nikke          Issue Monitored: nikke                       
> 06-02-06 04:23 Raymond        Note Added: 0010045                          
> 06-02-06 04:25 Raymond        Note Edited: 0010045                         
> 06-12-06 13:14 Mimosius       Issue Monitored: Mimosius                    
> 06-14-06 22:32 nikke          Note Added: 0010216                          
> 06-15-06 02:18 Raymond        Note Added: 0010221                          
> 06-15-06 02:27 Raymond        Note Edited: 0010221                         
> 06-15-06 11:03 Mimosius       Note Added: 0010237                          
> 06-15-06 23:43 nikke          Note Added: 0010246                          
> 06-16-06 13:01 Mimosius       Note Added: 0010250                          
> 06-16-06 13:16 Mimosius       Note Edited: 0010250                         
> 06-16-06 13:26 Raymond        Note Added: 0010251                          
> 06-16-06 13:31 Raymond        Note Edited: 0010251                         
> 06-16-06 13:37 Mimosius       Note Added: 0010252                          
> 06-16-06 16:25 Raymond        Note Added: 0010255                          
> 06-17-06 01:17 nikke          Note Added: 0010262                          
> 06-17-06 02:43 Raymond        Note Edited: 0010251                         
> 06-17-06 10:21 Raymond        Note Added: 0010266                          
> 06-17-06 10:24 Raymond        Note Edited: 0010266                         
> 06-17-06 11:02 Raymond        Note Added: 0010267                          
> 06-17-06 14:25 Raymond        Note Added: 0010268                          
> 06-17-06 15:16 nikke          Note Added: 0010269                          
> 06-17-06 16:10 Raymond        Note Added: 0010270                          
> 06-17-06 16:23 Raymond        Note Edited: 0010270                         
> 06-17-06 18:22 rlrevell       Note Added: 0010280                          
> 06-18-06 04:03 Raymond        Note Added: 0010295                          
> 06-18-06 04:08 Raymond        Note Edited: 0010295                         
> 06-18-06 04:14 Raymond        Note Edited: 0010295                         
> 06-18-06 13:30 Raymond        Note Edited: 0010295                         
> 06-19-06 13:11 Clemens LadischStatus                   new => assigned     
> 06-19-06 13:11 Clemens LadischAssigned To               => Clemens Ladisch 
> 06-19-06 13:33 Clemens LadischStatus                   assigned => resolved
> 06-19-06 13:33 Clemens LadischResolution               open => not fixable 
> 06-19-06 13:33 Clemens LadischNote Added: 0010307                          
> ======================================================================
>
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>
>   
