From: Mark Knecht <markknecht@attbi.com>
Subject: Re: Hammerfall DSP System Problems
Date: 22 Jun 2003 12:36:35 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1056310595.1790.2.camel@Wizard.knechthome.com>
References: <E19PnrW-0005mQ-00@sc8-sf-list1.sourceforge.net>
	 <Pine.LNX.4.53.0306120009030.1274@pi32.pi>
	 <1055414777.1404.6.camel@tpdrh.niptron.com>
	 <Pine.LNX.4.53.0306221053380.29109@pi32.pi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0306221053380.29109@pi32.pi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jesse Chappell <jesse@essej.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-06-22 at 07:57, Jesse Chappell wrote:
> On Thu, 12 Jun 2003, D R Holsbeck wrote:
> 
> > The newer Alsa code (with the new HDSP firmware code), has some new
> > device nodes, that dont get handled correctly if you are using the
> > devfs. I havent worked it all out yet, but running the snddevices script
> > will create them. Here is my list of my /dev/snd directory
> > 
> > Do you have all the device nodes setup? Especially the hwC*D* nodes? I
> > had problems running the hdsploader at first, because these nodes are
> > not being handled by the devfsd correctly.
> 
> No luck, running snddevices created the extra hw nodes but I got  
> the same behavior when running hdsploader.  The only node I had 
> before running the script was hwC1D0.
> 

Are any of you DSP users having any luck with the MIDI interface? I'm
finding it still drops lots of notes, which has so far stimied any
possibilities of my doing soft synths using Linux.

Thanks,
Mark



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
