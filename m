From: Danni Coy <rgcoy@midcoast.com.au>
Subject: audiowerksII
Date: 10 Jul 2002 12:06:34 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1026265279.2628.10.camel@eldar-forest>
References: <E17NGyU-0001Fk-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17NGyU-0001Fk-00@usw-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At 25 Jun 2002 21:33:07 +1000, 
Danni Coy wrote: 
> 
> I have an AudiowerksII from Emagic. I was wondering what steps I could
> take to get this supported by Alsa. I have some programming experience
> but have never worked on device drivers before. I have contacted
Emagic. 
> What Next? 

if you got a hardware spec, then take a look at the sources already 
existing.  there are likely drivers with the similar chip design. 
then copy it, and modify it. 

also, it would be better to ask Emagic whether the spec can be put on 
a public place, so that other developers can be involved with the 
development. 

unfortunately, there is no documentation about alsa kernel api. 
the source is only exact information. 
my old post on alsa-devel ML might help you to write a driver. 
please check the ml archive (or google). 

if you have no experience about writing device drivers, i recommend to 
read a book before actually coding.  a book from o'reily "linux device 
driver" is the best one.  it's even available on the web as a pdf 
file. 


ciao, 

Takashi 

Update... emagic looks to have been bought out by apple.... Has anyone 
had experience dealing with this company before....  

AFAIK the card is pretty much unique.... 
The main logic chip is a 	
				PHILIPS 
				SAA 7146A HZ
				CA1950.0
				ktD9917V2

It cost me $500 dollars and It has a warm crisp sound that I haven't
been able to get from anything else.

Does anybody have any clues....



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Stuff, things, and much much more.
http://thinkgeek.com/sf
