From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: alsa-driver-1.0.4rc1 missing snd-usb-usx2y ?
Date: Tue, 30 Mar 2004 00:51:41 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32796.192.168.1.5.1080604301.squirrel@www.rncbc.org>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>    
    <200403292129.04497.annabellesgarden@yahoo.de>  
    <32817.192.168.1.5.1080596468.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32817.192.168.1.5.1080596468.squirrel@www.rncbc.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Just checked out 1.0.4rc1 a few moments ago and I'm already missing the
snd-usb-usx2y module. AFAICT it's not being included by
./configure --with-cards option, nor it gets built when one sets
--with-cards=all.

I am quite sure this was being built as of 1.0.3 and before. The source
files are in fact on the tarball, but aren't picked up by the build
process, at least as I use to, nor does it appear on ./configure --help
anymore.

Maybe I'm doing something fundamentally wrong. My ol'time build steps used
to be just the following:

./configure --with-isapnp=no --with-sequencer=yes --with-oss=yes
--with-cards=all
make
make install

Am I missing some fine print since 1.0.3 release? The above worked out
simply fine until then.

Now that I'm with a US-224 on my hands for going after some party, this
feels somewhat unconfortable if not disappointing. Is this intentional or
just some mistake?

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
