From: =?iso-8859-1?q?Christian=20Bjerreskov?= <bjerreskov@yahoo.com>
Subject: Alsa - readi() - segmentation fault
Date: Thu, 1 Apr 2004 13:53:04 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040401125304.28925.qmail@web14523.mail.yahoo.com>
References: <E1B91Tq-0003yu-Su@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1B91Tq-0003yu-Su@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I have a problem concerning the format of the alsa lib
api. In the program I use the format
SND_PCM_FORMAT_S16_LE and therefore the data array is
decleared as a short int. But when the size of the
data array succeeds 512 I get a segmentation fault. To
me it looks like it's the readi() that fails...!

Hope someone will be able to guide me down the right
path!

Christian


	
	
		
___________________________________________________________
WIN FREE WORLDWIDE FLIGHTS - nominate a cafe in the Yahoo! Mail Internet Cafe Awards  www.yahoo.co.uk/internetcafes 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
