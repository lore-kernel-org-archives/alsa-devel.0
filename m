From: Raymond <rayau@netvigator.com>
Subject: Re: Alsa mix in HW
Date: Tue, 06 Sep 2005 17:26:34 +0800
Message-ID: <431D60CA.9060704@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dino Puller <dino@e4a.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dino wrote:

 > Raymond wrote:
 >
 > > How can I link the demo.cpp (a simple openal/opengl program) with the
 > > openal-alsa ? (It can be executed when link with openal)
 >
 > No problem here for compile/linking, i've attached a simple tested
 > Makefile, i used dynamic library with the name: libopenal.so.0   . If
 > you have problem tell me.
 >
 > CC = g++
 >
 > TARGET = lesson3
 >
 > COMPILEFLAGS =  -g
 > LIBS = -lopenal -lglut
 > INC = -I../../include
 >
 > $(TARGET): demo.o
 > $(CC) -o $(TARGET) demo.o  $(COMPILEFLAGS) $(LIBS) $(INC)
 >
 > demo.o: demo.cpp
 > $(CC) -c demo.cpp -Wno-deprecated
 >
 > clean:
 > rm -f $(TARGET) demo.o

It seem to me that your Makefile is wrong.

$(COMPILEFLAGS) and $(INC) should be in $(CC) -c demo.cpp


# demo]# make
Makefile:10: *** missing separator.  Stop.


Have you run the demo when linked with openal-alsa ?

Is there any gain in FPS when using openal-alsa ?








-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
