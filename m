From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Question on hda sigmatel codec dmics
Date: Sat, 10 Mar 2007 21:13:44 -0800
Message-ID: <5FD5754DDBA0B1499B5A0B4BB5419485B46185@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Folks:
 
I have yet another question; this having to do with the arrays of dmic
nids for the STAC 9205. I look at the 
patch_sigmatel.c file; the following section:
 
================================================
static hda_nid_t stac9205_mux_nids[2] = {
        0x19, 0x1a
};
 
static hda_nid_t stac9205_dmic_nids[3] = {
        0x17, 0x18, 0
};
 
static hda_nid_t stac9200_pin_nids[8] = {
        0x08, 0x09, 0x0d, 0x0e,
        0x0f, 0x10, 0x11, 0x12,
================================================
 
I notice that the dmic_nids array of hda_nit_t structure has one with a
value of zero, 
but the others, pin_nids and mux_nids don't. Later in the patch_9205
code, the num_dmics
is 2.
 
Why the extra dmic_nid with a value of 0?
 
Thanks
 
Mark Allyn

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
