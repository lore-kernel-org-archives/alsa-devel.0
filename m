From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: snd_kcontrol_new_t
Date: Thu, 15 May 2003 19:55:44 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030515195544.22379.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

typedef struct _snd_kcontrol_new {
	snd_ctl_elem_iface_t iface;	/* interface identifier */
	unsigned int device;		/* device/client number */
	unsigned int subdevice;		/* subdevice (substream) number */
	unsigned char *name;		/* ASCII name of item */
	unsigned int index;		/* index of item */
	unsigned int access;		/* access rights */
	unsigned int count;		/* count of same elements */
	snd_kcontrol_info_t *info;
	snd_kcontrol_get_t *get;
	snd_kcontrol_put_t *put;
	unsigned long private_value;
} snd_kcontrol_new_t;

I'd like some explanation (or pointer to where I can read about) the meaning/use
of some fields.  (The comments say what they are, but not what they are FOR).

What is the effect of setting the device,subdevice or index number when creating
a control?  It seems that I can leave them set to 0 as long as the name is
unique.

(as I mentioned in another post) I get trouble if I try to create two controls
with the same name and different indices (by two calls to snd_ctl_add)
Perhaps the only legal way to do this is to set count > 1 and create a set of
controls with one call to snd_ctl_add()?

Background:
I want to represent the control of this card
http://www.audioscience.com/internet/products/asi6244.htm
(The web page has a diagram on it, you won't have to download any document)
In the diagram, every input to every mixer has a separate attenuation control
"Volume" which is not explicitly shown for space reasons.

and others from
http://www.audioscience.com/internet/products

thanks

Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
