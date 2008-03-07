From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ALSACTL wrong restore on ARM9
Date: Fri, 07 Mar 2008 15:19:13 +0000
Message-ID: <1204903153.6429.38.camel@localhost.localdomain>
References: <002201c88065$972cb180$c5861480$@bouin@kerlink.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 221942460E
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 16:19:15 +0100 (CET)
In-Reply-To: <002201c88065$972cb180$c5861480$@bouin@kerlink.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-03-07 at 16:11 +0100, Alexandre BOUIN wrote:
> Hi list,
> 
> I'm using an intern AT91SAM92620-EK board with a WM8900 codec.
> ALSACTL restores bad values to controls after doing this : 
> 
> $ rm /var/lib/alsa/asound.state
> $ alsactl store
> $ alsactl restore
> 
> Anyone has seen this issue before ?
> Any ideas to solve it ? (I don't know much these utils neither alsa API)
> Could it come from our ASoC codec driver ?
> 

Can you describe 'bad values' in a little more detail.

Liam 
