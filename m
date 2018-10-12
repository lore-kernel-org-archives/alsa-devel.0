From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: usb: initial USB Audio Device Class
	3.0 support
Date: Fri, 12 Oct 2018 16:48:23 +0300
Message-ID: <20181012134823.GA1711@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F1D3267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 15:48:32 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ruslan.bilovol@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Ruslan Bilovol,

The patch 9a2fe9b801f5: "ALSA: usb: initial USB Audio Device Class
3.0 support" from Mar 21, 2018, leads to the following static checker
warning:

	sound/usb/stream.c:971 snd_usb_get_audioformat_uac3()
	warn: potentially allocating too little.  7 vs 1

sound/usb/stream.c
   943          /*
   944           * Get number of channels and channel map through
   945           * High Capability Cluster Descriptor
   946           *
   947           * First step: get High Capability header and
   948           * read size of Cluster Descriptor
   949           */
   950          err = snd_usb_ctl_msg(chip->dev,
   951                          usb_rcvctrlpipe(chip->dev, 0),
   952                          UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
   953                          USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
   954                          cluster_id,
   955                          snd_usb_ctrl_intf(chip),
   956                          &hc_header, sizeof(hc_header));
                                ^^^^^^^^^^
It looks like this comes from the USB (untrusted).

   957          if (err < 0)
   958                  return ERR_PTR(err);
   959          else if (err != sizeof(hc_header)) {
   960                  dev_err(&dev->dev,
   961                          "%u:%d : can't get High Capability descriptor\n",
   962                          iface_no, altno);
   963                  return ERR_PTR(-EIO);
   964          }
   965  
   966          /*
   967           * Second step: allocate needed amount of memory
   968           * and request Cluster Descriptor
   969           */
   970          wLength = le16_to_cpu(hc_header.wLength);
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
My private build of Smatch complains that all le16_to_cpu() data
probably comes from untrusted sources.

   971          cluster = kzalloc(wLength, GFP_KERNEL);
                ^^^^^^^
Maybe we're not allocating enough bytes for the cluster struct (8 bytes).

   972          if (!cluster)
   973                  return ERR_PTR(-ENOMEM);
   974          err = snd_usb_ctl_msg(chip->dev,
   975                          usb_rcvctrlpipe(chip->dev, 0),
   976                          UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
   977                          USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
   978                          cluster_id,
   979                          snd_usb_ctrl_intf(chip),
   980                          cluster, wLength);
   981          if (err < 0) {
   982                  kfree(cluster);
   983                  return ERR_PTR(err);
   984          } else if (err != wLength) {
   985                  dev_err(&dev->dev,
   986                          "%u:%d : can't get Cluster Descriptor\n",
   987                          iface_no, altno);
   988                  kfree(cluster);
   989                  return ERR_PTR(-EIO);
   990          }
   991  
   992          num_channels = cluster->bNrChannels;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   993          chmap = convert_chmap_v3(cluster);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This code assumes that cluster is large enough without checking.

   994          kfree(cluster);
   995  

regards,
dan carpenter
