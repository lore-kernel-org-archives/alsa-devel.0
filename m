From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: hdsp: potential oops in snd_hdsp_info_pref_sync_ref()
Date: Fri, 6 Jan 2012 16:59:57 +0300
Message-ID: <20120106135957.GA4316@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B705103851
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 15:00:11 +0100 (CET)
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by acsinet15.oracle.com (Switch-3.4.4/Switch-3.4.4) with ESMTP id
	q06E07FU000582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <alsa-devel@alsa-project.org>; Fri, 6 Jan 2012 14:00:08 GMT
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	q06E06Uh000977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Fri, 6 Jan 2012 14:00:07 GMT
Received: from abhmt104.oracle.com (abhmt104.oracle.com [141.146.116.56])
	by acsmt357.oracle.com (8.12.11.20060308/8.12.11) with ESMTP id
	q06E04gR014973
	for <alsa-devel@alsa-project.org>; Fri, 6 Jan 2012 08:00:06 -0600
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

My static check complains that there is a potential oops here but I'm
not sure what the correct fix is.

sound/pci/rme9652/hdsp.c
  2631          switch (hdsp->io_type) {
  2632          case Digiface:
  2633          case H9652:
  2634                  uinfo->value.enumerated.items = 6;
  2635                  break;
  2636          case Multiface:
  2637                  uinfo->value.enumerated.items = 4;
  2638                  break;
  2639          case H9632:
  2640                  uinfo->value.enumerated.items = 3;
  2641                  break;
  2642          default:
  2643                  uinfo->value.enumerated.items = 0;
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We set this to zero here.

  2644                  break;
  2645          }
  2646  
  2647          if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
enumerated.item is unsigned int so it's always greater or equal to zero.

  2648                  uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;

We set it to UINT_MAX here.

  2649          strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Reading UINT_MAX beyond the end of the array here will probably oops.

  2650          return 0;

There is a similar issue in snd_asihpi_cmode_info().

regards,
dan carpenter
