From: Patrice Tisserand <Patrice.Tisserand@ircam.fr>
Subject: Re: RME 9632 Mixer...
Date: 26 May 2004 15:13:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1085577205.9061.24.camel@lithium.ircam.fr>
References: <40B3A472.5050206@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40B3A472.5050206@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ed Wildgoose <lists@wildgooses.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-05-25 at 21:54, Ed Wildgoose wrote:
> ...is driving me nuts.  Everytime I turn on the PC I need to find a PC 
> with SSH to adjust the mixer controls so that I can hear some sound (no 
> mouse and a tiny TV resolution on the box itelf)
> 
> Can anyone suggest how to script the controls to default to some known 
> values?  I'm using alsa from around kernel 2.6.5 ish (which I believe 
> Thomas said has had the alsactl options removed, certainly I can't 
> figure out how to make them work).  Pointers to relevant parts of the 
> driver appreciated even so that I can write something to set the mixers 
> to a nice default.
> 
Don't know if it will work with 2.6.5, but you can try to add a script
which call amixer after hdsploader.
You will find some information on hdsp routing at the following url:
http://pd.klingt.org/files/hdsp-howto.html#controlling_output_routing

Bye,
Patrice.
-- 
Knowledge belongs to humanity.



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
