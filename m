From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: HDSP Line Out Volume Control?
Date: Fri, 22 Nov 2002 00:10:15 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDCF757.8080506@boosthardware.com>
References: <20021120151934.GA4999@dogsolitude.org> 	<3DDBFAA0.7CB10A5C@telia.com> <1037885686.7938.33.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thomas Charbonnel wrote:
> 
> I asked Paul once about the matrix mixer.
> His answer was :
> 
> <quote>
> first value: input source
> second value: output source
> third value: gain
> 
> input source: 0-25  (physical channels), 26-51 (audio output streams)
> output source: 0-27 (physical channels)
> 
> output channels 26 and 27 are the two line outs on the I/O box.
> </quote>
> 
> As Michael is stating, full volume (100% in alsamixer, or full 65536
> value in the matrix mixer) causes distortion. 50%, or 32786, seems to be
> the highest distortion-free value. I already mentioned this on the list
> but got no answer.
> 
> I succesfully tested the matrix mixer, using both amixer and the alsa
> mixer api. Here's an amixer example with the values you picked above :
> amixer cset numid=5 26,26,32786
> amixer cset numid=5 27,27,32786

This is the kind of information that should be submitted as a note to 
the alsa-docs. If you submit it then people will associate your name 
with the info.

Currently not one person has provided anything for the advanced multi 
channel devices :(


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
