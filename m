From: Christoph Sassenberg <sassi@sforce.org>
Subject: ALC Chips, now Realtek...
Date: Fri, 17 May 2002 16:41:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020517164123.7630a0bf.sassi@sforce.org>
References: <E178Qdh-0008Ow-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E178Qdh-0008Ow-00@usw-sf-list2.sourceforge.net>
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

Hi,


on my Epox 8K3A, there is a VT8233 together with an ALC201A Codec,
which does not work, as far I could figure out.
On Realtek HP I found as a Linux driver for that codec a modified
version of alsa-driver-0.5.11.

<-- snip from a97_codec.c -->

//====== added by hou 01/15/02
//      {       0x414c4710,     "ALC200/200P"			},
        {       0x414c4320,     "ALC100/100P"			},
        {       0x414c4710,     "ALC200"              		},
        {       0x414c4711,     "ALC201"       			},
        {       0x414c4712,     "ALC201A"                       },
  	{	0x414c4713,	"ALC201-G"			},
	{	0x414c4720,	"ALC650"			},
        {       0x414c4721,     "ALC650-D"   			},
 	{	0x414c4730,	"ALC101"			},
        {       0x414c4740,     "ALC202A-A"			},
        {       0x414c4741,     "ALC202-B"			},
        {       0x414c4742,     "ALC202A-C"			},
        {       0x414c4750,     "ALC250"          		},


and later on...

//====  added by hou 01/15/02   
	reg = snd_ac97_read(ac97, AC97_SIGMATEL_DAC2INVERT);
//      printk("id 0x%8x, ext 0x%x.\n", ac97->id, reg);
 	
        switch(ac97->id & 0xfffffff0) {
	case 0x414c4320:
 	case 0x414c4730:
	case 0x414c4750:
  	 	ac97->id = ac97->id & 0xfffffff0;
	        break;
   	case 0x414c4710:
		if ((reg & 0x0f) == 0)    
                	ac97->id = 0x414c4710;
        	else if ((reg & 0x0ff) == 0x11)
                        ac97->id = 0x414c4711;
		else if ((reg & 0x0ff) == 0x13)
                        ac97->id = 0x414c4712;
			        else if ((reg & 0x0ff) == 0x16)
 	                ac97->id = 0x414c4713;
	        else
                        ac97->id = 0x414c4710;
                break;  
 	case 0x414c4720:
                if (((reg & 0x0f) > 0) && ((reg & 0x0f) < 4))
                        ac97->id = 0x414c4720;
	        else if (((reg & 0x0f) > 3) && ((reg & 0x0f) < 8))
                        ac97->id = 0x414c4721;


As there are now these "bitmasks" in new ac97_codec.c, these chips can
be identified (as a start)...

Question: Is anybody working on that ALC stuff?


Regards,

	Sassi




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
