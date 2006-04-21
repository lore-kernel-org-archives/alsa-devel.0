From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: seq_midi client names
Date: Fri, 21 Apr 2006 09:45:58 +0200
Message-ID: <20060421074558.GB8672@turing.informatik.uni-halle.de>
References: <200604121402.48859.gineera@aspect135.co.uk>
 <200604131354.45544.gineera@aspect135.co.uk>
 <20060413152617.GB1147@turing.informatik.uni-halle.de>
 <200604191247.12207.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200604191247.12207.gineera@aspect135.co.uk>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alan Horstmann wrote:
> Summary: Change seq_midi.c so client name is card, rather than port, specific
> 
> Change snd_seq_midisynth_register_port() in seq_midi.c so that if a new client 
> is created, the client name string is based on card->shortname not 
> (port-specific) info->name.

Thanks, applied.

Clemens


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
