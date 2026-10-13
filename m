Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B3ACC6B33
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:32:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 594906021B;
	Thu, 15 Oct 2026 12:31:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 594906021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792060323;
	bh=GliNkEv4f5oaxNNjOVax3rnIxeu6bYxuNBj+S/JWY60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s5tRhWLpxjYPqQgPg6AcTkp0p+ZHFUhAo5xMtLpg2mgQ0PrYrw7qOhzvHdHD6wqx+
	 KGG7Pb2WmNpCD9KU/LuYw6qQcVWzzlr6T8OglYofkB86ckRDPmNb2Fo5L9L9Vq6oTH
	 2t48DSp4uMgxh5CU7eaqNWS80tGcAqai36NQp+0Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B357DF805F8; Thu, 15 Oct 2026 12:31:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73B31F80600;
	Thu, 15 Oct 2026 12:31:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7702AF800FA; Thu, 15 Oct 2026 12:31:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792060279;
	b=XMkEVyFVEPt5Vkl1c3N0De3Up5eJOcIvGJrIT2DO4cd5qolNAQ9krbbIB1fruYWsE9M3
	 1e5xCYjDwFJI8dqXLVscPIFTP03bLLmjXVC5LFS8HW5VOeW3hZiCA8hbpPZI/rbLnbI+z
	 Ci6X62LmUtufZ/L/rFCHP2JlvwzmqPvrDczUJKyJtL+UL1ndf/ekRTZi94hEi85hN4unm
	 7xbLtpi5sd/bEAgdHz/1/Kpi2gOMc84VpEFaZqV5Bvb33LkMgWmVKYy2FRc1748s4norX
	 p3Fot03wPSYMWP8wCuQMYa6tyE3tasxytSA5BnpNJx/BkVES0jDKb0OMV88k8ROEV5w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792060279;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=GliNkEv4f5oaxNNjOVax3rnIxeu6bYxuNBj+S/JWY60=;
	b=a8ld4bKB1Xw/P9HhQ9ZW7AgFrOWLoqhDAXaEOezgYFRUKuyzz8LSogPCvoQOyJuecHJn
	 tXq+mUirjU5ZgSUCtME555U99XJx01e/LMvh/aQgVMOwv/rzB+i9bxHeouaWrlam5qHyo
	 dg8nJY6m138j1c51w0TsGFkDU+Ssmr3YNTXj+c/+APvz3S2nafsZwC0ouc8hRSgtsNvtp
	 86lEe+bvJ7NnlKh8VXWj/VpVAGlMoq0dyiZcL3begxT0SeqLtLn/+AlBko/aMcCZKvuRh
	 q+jVGKLDqgLbJXSduToyOgOeKKzDSkKYO97D8xhYveF9ObZd1X3UnO36hgql61ZmeQw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=anAiLvI9;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 73710F8026D;
	Thu, 15 Oct 2026 12:31:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73710F8026D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=anAiLvI9
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E29B41765;
	Thu, 15 Oct 2026 10:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7451F000C4;
	Thu, 15 Oct 2026 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060273;
	bh=79LtDdXUGnQRvSGTVgG4tAzTgUO9Gbk0LFtaWpy2oig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=anAiLvI9xUWtRWgpajPIn8M95hBrsNXxS4yzI/1jJGnQTcGdkCuBR6zwpcSBMaYac
	 KzWJwpZ7rerDyRJtBUv3H+zF/zD/2cTHHcRoVshIxKNKxNRbRG8zRPPB+viASL+ZjH
	 hUklbufMqLsDQ/pwlR36HW/t76/Jol2W0GZjhULy99MhqQTEY3JlzNsoWGlZPT9Qr5
	 4YFoyUnEw4pi+SfayeVkdc54ejrtyoV1lXE+H+Bxvh8Qe2WUNse2kWlJWp7eCPEbvb
	 fNLkeUPYfl8RtABt54DBdJSsA2V3NDtBU2H/5Rcug1Pj8zJFkM3dOG57tf1qa+OO9P
	 VICndq4GCqGhA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/9] ASoC: SOF/amd: ACP7.B support and ASP carveout
 firmware loading
Message-Id: <179191856632.42298.5680316320552393906.b4-ty@b4>
Date: Tue, 13 Oct 2026 20:09:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2750; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GliNkEv4f5oaxNNjOVax3rnIxeu6bYxuNBj+S/JWY60=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIurM7hqZw4b1GbiXqwb875pblT4r/fv/3oyTHtDzU7i
 lwCw9iUO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjAR5euMDBsmb9rP9rFDWLtX
 z1KFscBwoY2WdeJ2Jid/xVuHrJTWFzEy9PnoBdpXflZgqsmPYrl83un/0fjbLzvCLVluVftPk/7
 EBQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 6HUTT4N26JIERAXHNYVKMKTPB2GU73XW
X-Message-ID-Hash: 6HUTT4N26JIERAXHNYVKMKTPB2GU73XW
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6HUTT4N26JIERAXHNYVKMKTPB2GU73XW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 13 Oct 2026 21:11:32 +0530, Vijendar Mukunda wrote:
> ASoC: SOF/amd: ACP7.B support and ASP carveout firmware loading
> 
> This series adds ACP7.B platform support to the AMD SOF driver stack
> and implements the ASP-authenticated firmware load path required by
> both ACP7.B and ACP7.F.
> 
> Patches 1-2 are preparatory renames and restructuring. The existing
> acp7x machine table and chip descriptor are renamed to acp7f to
> accurately reflect the hardware they target (ACP7.F). The probe
> callback is restructured to select the per-revision descriptor via a
> dedicated static pci_device_id entry rather than encoding it in
> driver_data of the shared ID table.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/9] ASoC: SOF: amd: rename acp7x machine table and descriptor to acp7f
      https://git.kernel.org/broonie/misc/c/929e433b8cbc
[2/9] ASoC: SOF: amd: select descriptor per PCI revision in acp7x probe
      https://git.kernel.org/broonie/misc/c/f84363861e44
[3/9] ASoC: amd: add I2S machine table for ACP7.B
      https://git.kernel.org/broonie/misc/c/9246ac5b5c99
[4/9] ASoC: SOF: amd: add ACP7.B chip descriptor and wire per-revision probe
      https://git.kernel.org/broonie/misc/c/44f8d28191f1
[5/9] ASoC: SOF: amd: Propagate PCI subsystem Vendor and Device IDs
      https://git.kernel.org/broonie/misc/c/b2dc10ee0b51
[6/9] ASoC: SOF: amd: consolidate local variable declarations
      https://git.kernel.org/broonie/misc/c/b23e9b1f3b4c
[7/9] ASoC: amd: acp: add acp-mach-common.h for shared machine driver types
      https://git.kernel.org/broonie/misc/c/0e4c4081169b
[8/9] ASoC: SOF: amd: propagate pdm_sel to SDW machine driver via mach->pdata
      https://git.kernel.org/broonie/misc/c/439c43d9628e
[9/9] ASoC: SOF: amd: add ASP carveout firmware loading for ACP7.B/7.F
      https://git.kernel.org/broonie/misc/c/cec3598305a6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

