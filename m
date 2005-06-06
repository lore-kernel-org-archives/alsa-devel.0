From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Mon, 06 Jun 2005 10:09:26 +0800
Message-ID: <42A3B056.30405@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The au88x0 driver need patch to run on 64-bits platform.

http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948


bugtrack@alsa-project.org wrote:
> The following issue has been SUBMITTED.
> ======================================================================
> <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1138> 
> ======================================================================
> Reported By:                penguinparty
> Assigned To:                mjander
> ======================================================================
> Project:                    ALSA - driver
> Issue ID:                   1138
> Category:                   PCI - au88x0
> Reproducibility:            always
> Severity:                   crash
> Priority:                   normal
> Status:                     assigned
> Distribution:               ubuntu 5.04
> Kernel Version:             2.6.11.11 2.6.11.8 and 2.6.10
> ======================================================================
> Date Submitted:             05-28-2005 22:22 CEST
> Last Modified:              05-28-2005 22:22 CEST
> ======================================================================
> Summary:                    errors when installing au8820 modules
> Description: 
> Please see the section additional information for a dump of my dmesg output
> regarding the au8820 module.
> 
> I have tried installing this module using 2.6.11.11 2.6.11.8 and 2.6.10
> kernels. The shipping alsa support under each of these kerenls provies me
> with the same result. I have also tried installing each of these kernels
> without alsa support only CONFIG_SOUND and then installing the
> alsa-drivers 1.0.9rc4a
> 
> I get the same result every time I do the modprobe snd-au8820
> 
> Using older versions of debian as well as the ubuntu live cd's I am able
> to get this sound card working.
> ======================================================================
> 
> Issue History
> Date Modified  Username       Field                    Change              
> ======================================================================
> 05-28-05 22:22 penguinparty   New Issue                                    
> 05-28-05 22:22 penguinparty   Distribution              => ubuntu 5.04     
> 05-28-05 22:22 penguinparty   Kernel Version            => 2.6.11.11 2.6.11.8
> and 2.6.10
> ======================================================================
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
