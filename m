From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Problem compiling latest CVS with gcc-2.95.3
Date: Sat, 8 Mar 2003 23:44:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030308224427.GA25823@tuba.home>
References: <Pine.GSO.4.53.0303081049350.29156@oneiro.csd.uch.gr> <20030308091124.GA29733@tuba.home> <20030308094052.GB29733@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030308094052.GB29733@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: papadako@csd.uoc.gr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 08, 2003 at 10:40:52AM +0100, Martin Langer wrote:
> On Sat, Mar 08, 2003 at 10:11:24AM +0100, Martin Langer wrote:
> > On Sat, Mar 08, 2003 at 10:51:29AM +0200, Panagiotis Papadakos wrote:
> >
> > > cc1: Invalid option `-falign-functions=4'


Removing that option really helps in my case. Don't know if it should be
really applied to the CVS tree.

martin


--- alsa-driver/configure.in.ORIGINAL	Sat Mar  8 23:20:05 2003
+++ alsa-driver/configure.in	Sat Mar  8 23:20:54 2003
@@ -430,7 +430,7 @@
     if $CC -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then
       c_opts="-march=athlon"
     else
-      c_opts="-march=i686 -falign-functions=4"
+      c_opts="-march=i686"
     fi
     ;;
   crusoe)


> Another machine (same Alsa-CVS, both debian woody) shows a different problem:
> 
> ainstr_simple.o: file not recognized: File truncated

latest CVS has no longer that problem. It compiles fine.


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
