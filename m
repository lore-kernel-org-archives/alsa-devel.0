From: Jesse Chappell <jesse@essej.net>
Subject: Re: Hammerfall DSP System Problems
Date: Sun, 22 Jun 2003 10:57:12 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0306221053380.29109@pi32.pi>
References: <E19PnrW-0005mQ-00@sc8-sf-list1.sourceforge.net>
 <Pine.LNX.4.53.0306120009030.1274@pi32.pi> <1055414777.1404.6.camel@tpdrh.niptron.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1055414777.1404.6.camel@tpdrh.niptron.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: D R Holsbeck <drh@niptron.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jun 2003, D R Holsbeck wrote:

> The newer Alsa code (with the new HDSP firmware code), has some new
> device nodes, that dont get handled correctly if you are using the
> devfs. I havent worked it all out yet, but running the snddevices script
> will create them. Here is my list of my /dev/snd directory
> 
> Do you have all the device nodes setup? Especially the hwC*D* nodes? I
> had problems running the hdsploader at first, because these nodes are
> not being handled by the devfsd correctly.

No luck, running snddevices created the extra hw nodes but I got  
the same behavior when running hdsploader.  The only node I had 
before running the script was hwC1D0.

jlc



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
