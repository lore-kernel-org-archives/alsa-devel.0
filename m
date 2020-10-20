Return-Path: <SRS0=iKR9=D3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080DC433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:35:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C1E2225F
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Oct 2020 05:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FDZPVBaT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ke38N5q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C1E2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAFE316F9;
	Tue, 20 Oct 2020 07:34:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAFE316F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603172137;
	bh=AEjaf3UfKaxWldo4A/xgnNKzbkSqeJdNCtlr8WP3dnY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FDZPVBaT0OWTwQabKRjAxQSIdXRAC/c2w3B61hRhVkTt+767bs/0KNu9OJaEvppi9
	 nIaLsOXqcyiC7pXCm2HbxEjaj3SrWbM0JyTDOQDbpArWljJwLMadmeXytQSgQzj8Yj
	 qMe0qiwWOttC/AWTJSEIrJbW3yoSPmo5wTlCh0C8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D013F801A3;
	Tue, 20 Oct 2020 07:34:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95EE3F801F2; Tue, 20 Oct 2020 07:34:44 +0200 (CEST)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98EFFF8011E
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2020 07:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98EFFF8011E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Ke38N5q/"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f8e76da0004>; Mon, 19 Oct 2020 22:34:18 -0700
Received: from [10.25.98.225] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 20 Oct
 2020 05:34:19 +0000
Subject: Re: [PATCH v4 08/15] Documentation: of: Convert graph bindings to
 json-schema
To: Rob Herring <robh@kernel.org>
References: <1602859382-19505-1-git-send-email-spujar@nvidia.com>
 <1602859382-19505-9-git-send-email-spujar@nvidia.com>
 <20201019215628.GA3650804@bogus>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <e7d87e41-c92f-9a22-f7ca-a80e080e7bf1@nvidia.com>
Date: Tue, 20 Oct 2020 11:04:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019215628.GA3650804@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603172058; bh=71Qu84vQi0DIkoSmwEIX9OVoUxeXBtrR1oA2TDmZDGc=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=Ke38N5q/2H7vPjiE/VhE9zx9IZ2OBv9Mg9b6NgMOlpsFAKukiMRkkG3j1CV4ZZB+D
 4uQ7PVFpA3F9P2jhQxaXm1FIRd4dPhaQjMP1Ki0ykpdD0s2HiSWBlDg3LZJp6SKjwx
 OvcjkQM2LDMFZzE9kE51qcbXzHbi3rkK+OFoMuSkz5966RY196hlOn609UBDPPnFE/
 TWBEutgjaygeghEraEKKtqJwvFoO2DBHzbcFj6bG2H0y7BIggoW/o/Clxvia80Vw3S
 asAkjWZf+Gu7aenrrkz44nwvnKKc0xPf2DIRxFw9DBU3T2XMT3RLOq0vkzuE8Ndb6G
 S9iErsqUnvIIg==
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 atalambedu@nvidia.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
 rlokhande@nvidia.com, swarren@nvidia.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, jonathanh@nvidia.com,
 devicetree@vger.kernel.org, nicoleotsuka@gmail.com, broonie@kernel.org,
 linux-tegra@vger.kernel.org, mkumard@nvidia.com, viswanathl@nvidia.com,
 lgirdwood@gmail.com, nwartikar@nvidia.com, p.zabel@pengutronix.de,
 sharadg@nvidia.com, dramesh@nvidia.com
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


>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>   Documentation/devicetree/bindings/graph.txt  | 128 -------------------=
-
>>   Documentation/devicetree/bindings/graph.yaml | 170 +++++++++++++++++++=
++++++++
>>   2 files changed, 170 insertions(+), 128 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/graph.txt
>>   create mode 100644 Documentation/devicetree/bindings/graph.yaml
> I'd like to move this to the dtschema repository instead.

Do you mean I need to separately submit this patch for dtschema repo?

...
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/graph.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common bindings for device graphs
>> +
>> +description: |
>> +  The hierarchical organisation of the device tree is well suited to de=
scribe
>> +  control flow to devices, but there can be more complex connections be=
tween
>> +  devices that work together to form a logical compound device, followi=
ng an
>> +  arbitrarily complex graph.
>> +  There already is a simple directed graph between devices tree nodes u=
sing
>> +  phandle properties pointing to other nodes to describe connections th=
at
>> +  can not be inferred from device tree parent-child relationships. The =
device
>> +  tree graph bindings described herein abstract more complex devices th=
at can
>> +  have multiple specifiable ports, each of which can be linked to one o=
r more
>> +  ports of other devices.
>> +
>> +  These common bindings do not contain any information about the direct=
ion or
>> +  type of the connections, they just map their existence. Specific prop=
erties
>> +  may be described by specialized bindings depending on the type of con=
nection.
>> +
>> +  To see how this binding applies to video pipelines, for example, see
>> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
>> +  Here the ports describe data interfaces, and the links between them a=
re
>> +  the connecting data buses. A single port with multiple connections ca=
n
>> +  correspond to multiple devices being connected to the same physical b=
us.
>> +
>> +maintainers:
>> +  - Philipp Zabel <p.zabel@pengutronix.de>
>> +
>> +definitions:
>> +
>> +  port:
>> +    type: object
>> +    description: |
>> +      If there is more than one 'port' or more than one 'endpoint' node
>> +      or 'reg' property present in the port and/or endpoint nodes then
>> +      '#address-cells' and '#size-cells' properties are required in rel=
evant
>> +      parent node.
> reg property.

done

>
>> +
>> +    patternProperties:
>> +      "^endpoint(@[0-9a-f]+)?$":
>> +        type: object
>> +        properties:
> reg?

done

>> +          remote-endpoint:
>> +            description: |
>> +              phandle to an 'endpoint' subnode of a remote device node.
>> +            $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  ports:
>> +    type: object
>> +    patternProperties:
>> +      "^port(@[0-9a-f]+)?$":
>> +        $ref: "#/definitions/port"
> No reason for this to be under 'definitions'. Just move down.

Would definitions be needed if some schemas want to refer the base graph=20
schema? Or is it like they can just directly include the base schema and=20
definitions are not really required?

But what if they want to extend few properties. For example:

graph.yaml
----------
endpoint {
 =C2=A0=C2=A0=C2=A0 remote-endpoint =3D <>;
};

*audio-graph-card.yaml
----------------------
endpoint {
 =C2=A0=C2=A0=C2=A0 remote-endpoint =3D <>;

 =C2=A0=C2=A0=C2=A0 property-x;
 =C2=A0=C2=A0=C2=A0 node-x {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
 =C2=A0=C2=A0=C2=A0 };
};

>
>> +
>> +properties:
>> +  ports:
>> +    $ref: "#/definitions/ports"
>> +
>> +patternProperties:
>> +  "^port(@[0-9a-f]+)?$":
>> +    $ref: "#/definitions/port"
>> +
>> +additionalProperties: false
> This needs to be true here. But you need this within 'ports' and 'port'.
> (I think... I think we only have extra properties within endpoint
> nodes.)

I think currently audio-graph allows few properties at port/ports. I am=20
not sure if Morimoto-san has plans to get rid of this.
