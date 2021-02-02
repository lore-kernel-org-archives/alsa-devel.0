Return-Path: <SRS0=BHSX=HE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0966CC433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 06:13:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B408764DC3
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Feb 2021 06:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B408764DC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5549F1769;
	Tue,  2 Feb 2021 07:12:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5549F1769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612246380;
	bh=E1MV578LDoAmvou8kGXel4nvDBDBDWw/Gl3MqBUUzWQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=itwdDPolreqc/BI+WUPslTTmeeKPvD8mFBZ66nJPplAAkf6uipCGia+Z3Vt0xkbXa
	 ge6AWKlxvj9ggY9ND2nTNTu7URNvyi0DdY/Co0dDfcbFJKjgQQnGiUQwUs0LsxbX8q
	 EGLmgbK8wilySUea9xroqlfMPV5QgoD4YmG4J6BQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4470F80152;
	Tue,  2 Feb 2021 07:12:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0F74F80171; Tue,  2 Feb 2021 07:12:07 +0100 (CET)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C2CAF8013C
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2021 07:11:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C2CAF8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com
 header.b="qP1PHMEu"
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1126A9NZ136897;
 Tue, 2 Feb 2021 06:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sJPK7k7v/pSLxvKjCf6UTf7Ipk2nyEZVDTPAkt2HfTc=;
 b=qP1PHMEubgoqGNd8AIdAuySGax/BI95Us9z72vrKSC/EV/T5L9btBNJrmrDVogrfN2AH
 mrOvUNv03BSvUfHwjPEuGrYTdpmQro93FyvxwIAnxajfncWb8JUUlN/17uLTbwCi/6vE
 AkMgSnUHN3elOCDH2SPyQPdTWVCjl273Y7rpBoyfo9JpbcLrFYChIpIL4vDJpgK7P1vZ
 Xd9S13SKeutQddO46TdDIZhz2wlkcaXF/RJcUi7XJDWy37wK0mT1bdUo6TdyExF70a+D
 S1k18v8NGyXbHuDdjTfUZqWLbJ1PAeMVtcojJbNmSWnJHcfjTE7P05m2cLx0oESZpdrv mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 36cxvr114a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Feb 2021 06:11:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1126AW1O049774;
 Tue, 2 Feb 2021 06:11:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 36dhcw4r24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 02 Feb 2021 06:11:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1126BnUp017443;
 Tue, 2 Feb 2021 06:11:51 GMT
Received: from kadam (/102.36.221.92) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 01 Feb 2021 22:11:49 -0800
Date: Tue, 2 Feb 2021 09:11:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [bug report] ALSA: rawmidi: Avoid racy info ioctl via ctl device
Message-ID: <20210202061142.GY20820@kadam>
References: <YBf6NOKafgp8XfDZ@mwanda>
 <s5hlfc7j531.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlfc7j531.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020043
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020043
Cc: alsa-devel@alsa-project.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Feb 01, 2021 at 02:22:10PM +0100, Takashi Iwai wrote:
> On Mon, 01 Feb 2021 13:55:16 +0100,
> Dan Carpenter wrote:
> > 
> > Hello Takashi Iwai,
> > 
> > The patch c1cfd9025cc3: "ALSA: rawmidi: Avoid racy info ioctl via ctl
> > device" from Dec 14, 2017, leads to the following static checker
> > warning:
> > 
> > 	sound/core/rawmidi.c:651 snd_rawmidi_info_select()
> > 	warn: called with lock held.  '&register_mutex'
> > 
> > sound/core/seq/seq_midi.c
> >    297          mutex_lock(&register_mutex);
> >                            ^^^^^^^^^^^^^^^
> > Holding this lock.
> > 
> >    298          client = synths[card->number];
> >    299          if (client == NULL) {
> >    300                  newclient = 1;
> >    301                  client = kzalloc(sizeof(*client), GFP_KERNEL);
> >    302                  if (client == NULL) {
> >    303                          mutex_unlock(&register_mutex);
> >    304                          kfree(info);
> >    305                          return -ENOMEM;
> >    306                  }
> >    307                  client->seq_client =
> >    308                          snd_seq_create_kernel_client(
> >    309                                  card, 0, "%s", card->shortname[0] ?
> >    310                                  (const char *)card->shortname : "External MIDI");
> >    311                  if (client->seq_client < 0) {
> >    312                          kfree(client);
> >    313                          mutex_unlock(&register_mutex);
> >    314                          kfree(info);
> >    315                          return -ENOMEM;
> >    316                  }
> >    317          }
> >    318  
> >    319          msynth = kcalloc(ports, sizeof(struct seq_midisynth), GFP_KERNEL);
> >    320          port = kmalloc(sizeof(*port), GFP_KERNEL);
> >    321          if (msynth == NULL || port == NULL)
> >    322                  goto __nomem;
> >    323  
> >    324          for (p = 0; p < ports; p++) {
> >    325                  ms = &msynth[p];
> >    326  
> >    327                  if (snd_seq_midisynth_new(ms, card, device, p) < 0)
> >    328                          goto __nomem;
> >    329  
> >    330                  /* declare port */
> >    331                  memset(port, 0, sizeof(*port));
> >    332                  port->addr.client = client->seq_client;
> >    333                  port->addr.port = device * (256 / SNDRV_RAWMIDI_DEVICES) + p;
> >    334                  port->flags = SNDRV_SEQ_PORT_FLG_GIVEN_PORT;
> >    335                  memset(info, 0, sizeof(*info));
> >    336                  info->device = device;
> >    337                  if (p < output_count)
> >    338                          info->stream = SNDRV_RAWMIDI_STREAM_OUTPUT;
> >    339                  else
> >    340                          info->stream = SNDRV_RAWMIDI_STREAM_INPUT;
> >    341                  info->subdevice = p;
> >    342                  if (snd_rawmidi_info_select(card, info) >= 0)
> >                             ^^^^^^^^^^^^^^^^^^^^^^^
> > We can't call this function when we're holding the lock or it leads to
> > a deadlock.
> 
> Those two register_mutex are different ones; i.e. both are local static
> variables, hence its scope is only for rawmidi.c and seq_client.c,
> hence they can't conflict with each other.
> 
> Or am I missing something else?
> 

Ah...  Sorry.  And I think I just sent you another bogus bug report a
few minutes ago.  :/

regards,
dan carpenter

