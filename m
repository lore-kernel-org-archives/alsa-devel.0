From: Frank Barknecht <barknech@ph-cip.uni-koeln.de>
Subject: Re: Multiple Audio Streams
Date: Tue, 8 Oct 2002 12:29:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021008102917.GA1304@fliwatut.scifi>
References: <3D9F3D84.4040102@boom.org.il> <1033859918.1118.24.camel@duron> <3DA15968.1000205@superbug.demon.co.uk> <3DA160E7.10608@boom.org.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DA160E7.10608@boom.org.il>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
Sagi Bashari hat gesagt: // Sagi Bashari wrote:

> James Courtier-Dutton wrote:
> 
> >There are other applications/tools you can use, one of which is "JACK" 
> >that allows for multiple audio streams mixed in software and lots of 
> >other cool stuff.
> 
> I used ARTS until now. But I don't want to use software mixing. The 
> latency is bad and it eats CPU for nothing, why use it when you have 
> hardware support?

That's what the JACK developers also thought, and that's why Jack has
excellent low latency. It's a design goal of Jack. The other goal is
something, that hardware mixing cannot achieve: Transparent
exchange of audio data between applications. With Jack you can use the
output of one programm as input to another program. 

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
